typedef void EventCallback(arg);

class EventBus {
  //私有化构造函数
  EventBus._internal();

  //单例
  static EventBus _instance = new EventBus._internal();

  //工厂构造函数
  factory EventBus() => _instance;

  //保存事件订阅者队列，key:事件名(id)，value: 对应事件的订阅者队列
  var _emap = new Map<Object, List<EventCallback>>();

  void on(eventName, EventCallback f) {
    if (null == eventName || null == f) return;
    _emap[eventName] ??= new List<EventCallback>();
    _emap[eventName].add(f);
  }

  void off(eventName, [EventCallback f]) {
    var list = _emap[eventName];
    if (null == eventName || null == list) return;
    if (f == null) {
      _emap[eventName] = null;
    } else {
      list.remove(f);
    }
  }

  void emit(eventName, [arg]) {
    var list = _emap[eventName];
    if (null == list) return;
    int len = list.length - 1;
    for (var i = len; i > -1; i--) {
      list[i](arg);
    }
  }
}

var bus = new EventBus();
