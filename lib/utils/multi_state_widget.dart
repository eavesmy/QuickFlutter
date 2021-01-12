import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// v1.0 of the file created on 2020/4/11 by shuxin.wei
///
/// 根据[error]构造出错误提示，目前不推荐使用了，可以直接在`Future`或`Stream`直接`Throw error;`
typedef ErrorTipsBuilder = String Function(dynamic error);
typedef LoadDataFuture<T> = Future<T> Function();
typedef LoadDataStream<T> = Stream<T> Function();
typedef ContentBuilder<T> = Widget Function(BuildContext context, T data);
typedef ErrorBuilder = Widget Function(
    BuildContext context, dynamic error, GestureTapCallback errorRetryTap);
typedef EmptyBuilder = Widget Function(BuildContext context, GestureTapCallback emptyRetryTap);
typedef LoadingBuilder = Widget Function(BuildContext context, ConnectionState state);

class IgnoreError implements Exception {
  final dynamic error;

  IgnoreError({this.error});

  @override
  String toString() {
    return error?.toString();
  }
}

///Example:
///```dart
///MultiStatusWidget<String>(
///      contentBuilder: (BuildContext context, String data) => Text(data),
///      loadDataFuture: () async {
///        try {
///          HttpClient client = new HttpClient();
///          var httpClientRequest = await client.getUrl(Uri.parse("http://www.baidu.com/"));
///          var httpClientResponse = await httpClientRequest.close();
///          if (httpClientResponse.statusCode == HttpStatus.ok) {
///            var data = await httpClientResponse.transform(Utf8Decoder()).join();
///            //To mock data is empty;
///            if (data.contains("result")) {
///              return null;
///            } else {
///              return data;
///            }
///          } else {
///            throw "网络出现问题:${httpClientResponse.statusCode}";
///          }
///        } catch (e) {
///          throw "未知异常$e";
///        }
///      },
///    ),
///```
class MultiStatusWidget<T> extends StatefulWidget {
  final LoadDataFuture<T> loadDataFuture;
  final LoadDataStream<T> loadDataStream;
  final ContentBuilder<T> contentBuilder;
  final String loadingTips;
  final String emptyTips;
  final String emptyRetryBtnText;
  final LoadingBuilder loadingBuilder;
  final ErrorBuilder errorBuilder;
  final EmptyBuilder emptyBuilder;

  MultiStatusWidget({
    Key key,
    this.loadDataFuture,
    this.loadDataStream,
    @required this.contentBuilder,
    this.loadingTips,
    this.emptyTips,
    this.emptyRetryBtnText,
    this.loadingBuilder,
    this.errorBuilder,
    this.emptyBuilder,
  })  : assert(!(loadDataFuture == null && loadDataStream == null),
            'LoadDataFuture and LoadDataStream cannot be null at the same time.'),
        assert(!(loadDataFuture != null && loadDataStream != null),
            'LoadDataFuture and LoadDataStream can only use one of them.'),
        super(key: key);

  @override
  _MultiState<T> createState() {
    return _MultiState<T>(contentBuilder);
  }
}

class _MultiState<T> extends State<MultiStatusWidget> {
  Future<T> _loadDataFuture;
  Stream<T> _loadDataStream;
  ContentBuilder<T> contentBuilder;

  _MultiState(this.contentBuilder);

  GestureTapCallback _retryTap;

  @override
  void initState() {
    _retryTap = () {
      setState(() {
        if (widget.loadDataFuture != null) _loadDataFuture = widget.loadDataFuture();
        if (widget.loadDataStream != null) _loadDataStream = widget.loadDataStream();
        //check again at run time.
        if (_loadDataFuture == null && _loadDataStream == null) {
          throw 'LoadDataFuture and LoadDataStream cannot be null at the same time.';
        }
        if (_loadDataFuture != null && _loadDataStream != null) {
          throw 'LoadDataFuture and LoadDataStream can only use one of them.';
        }
      });
    };
    super.initState();
    //首次进入页面，等待转场动画执行完成，否则转场效果会很卡
    Future.delayed(Duration(milliseconds: 400), () {
      _retryTap();
    });
  }

  @override
  Widget build(BuildContext context) {
    var builder = (BuildContext context, AsyncSnapshot<T> snapshot) {
      var connectionState = snapshot.connectionState;
      if (_loadDataFuture == null && _loadDataStream == null) {
        connectionState = ConnectionState.waiting;
      }
      switch (connectionState) {
        case ConnectionState.waiting:
        case ConnectionState.active:
          return widget.loadingBuilder == null
              ? DefaultLoadingWidget(
                  loadingTips: widget.loadingTips,
                )
              : widget.loadingBuilder(
                  context,
                  connectionState,
                );
          break;
        case ConnectionState.none:
        case ConnectionState.done:
          //结果响应，error!=null，出现错误
          if (snapshot.hasError) {
            return widget.errorBuilder == null
                ? DefaultErrorWidget(
                    errorMsg: snapshot.error is IgnoreError ? null : snapshot.error.toString(),
                    retryBtnText: widget.emptyRetryBtnText,
                    errorRetryTap: _retryTap,
                  )
                : widget.errorBuilder(
                    context,
                    snapshot.error,
                    _retryTap,
                  );
          }
          //data!=null，展示数据
          else if (snapshot.hasData) {
            return contentBuilder(context, snapshot.data);
          }
          //data == null 没有数据
          else {
            return widget.emptyBuilder == null
                ? DefaultEmptyLayout(
                    emptyTips: widget.emptyTips,
                    retryBtnText: widget.emptyRetryBtnText,
                    emptyRetryTap: _retryTap,
                  )
                : widget.emptyBuilder(
                    context,
                    _retryTap,
                  );
          }
          break;
        default:
          return Text("页面状态不正确");
      }
    };
    return widget.loadDataFuture == null
        ? StreamBuilder<T>(
            stream: _loadDataStream,
            builder: builder,
          )
        : FutureBuilder<T>(
            future: _loadDataFuture,
            builder: builder,
          );
  }
}

class DefaultEmptyLayout extends StatelessWidget {
  final String _defaultEmptyTips = '还没有任何内容';
  final String _defaultRetryBtnText = '点击刷新';
  final String emptyTips;
  final String retryBtnText;
  final GestureTapCallback emptyRetryTap;

  const DefaultEmptyLayout({this.emptyTips, this.retryBtnText, this.emptyRetryTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            emptyTips ?? _defaultEmptyTips,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF333333),
            ),
          ),
          GestureDetector(
            onTap: emptyRetryTap,
            child: emptyRetryTap == null
                ? Offstage()
                : Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFFF4D32),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        width: 180,
                        height: 40,
                        alignment: Alignment.center,
                        child: Text(
                          retryBtnText ?? _defaultRetryBtnText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFFFF4D32),
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class DefaultErrorWidget extends StatelessWidget {
  final String _defaultErrorTips = '请检查网络后点击重试';
  final String _defaultRetryBtnText = '点击重试';
  final String errorMsg;
  final String retryBtnText;
  final GestureTapCallback errorRetryTap;

  const DefaultErrorWidget({Key key, this.errorMsg, this.retryBtnText, this.errorRetryTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMsg ?? _defaultErrorTips,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF333333),
            ),
          ),
          GestureDetector(
            onTap: errorRetryTap,
            child: errorRetryTap == null
                ? Offstage()
                : Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFFF4D32),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        width: 180,
                        height: 40,
                        alignment: Alignment.center,
                        child: Text(
                          retryBtnText ?? _defaultRetryBtnText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFFFF4D32),
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class DefaultLoadingWidget extends StatelessWidget {
  final String loadingTips;
  final _defaultLoadingTips = '加载中...';
  final frameImages = [ ];

  final textColor;

  DefaultLoadingWidget({Key key, this.loadingTips, this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            loadingTips ?? _defaultLoadingTips,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor ?? Color(0xFF333333),
              fontSize: 14,
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}
