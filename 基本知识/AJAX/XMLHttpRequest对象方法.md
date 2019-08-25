# XMLHttpRequest对象方法

1.  abort  取消当前所发出的请求
2.  getAllResponseHeaders  取得所有的Http头信息
3.  getResponseHeader 取得制定的Http头信息
4.  **open 创建一个http请求，并制定请求模式（GET或者POST）**
5.  **send 将创建的请求发送到服务器，并接收回应消息**
6.  setRequestHeader 设置一个请求的HTTP头信息

# XMLHttpRequest对象的属性（重点）

1. onreadystatechange 指定当readState状态改变时使用的操作，一般都用于指定具体的回掉函数
2. readyState 返回当前请求的状态，只读
3. responseBody 将回应信息正文以unsigned byte数组形式返回，只读
4. responseStream 以Ado Stream对象的形式返回响应信息，只读
5. responseText 接收以普通文本返回的数据，只读
6. responseXML 接收以XML文档形式返回的信息，只读
7. status 返回当前请求的http状态码，只读
8. statusText返回当前请求的响应行状态，只读



当请求发送到服务器端并处理完成后，所返回的数据有两种类型：

1. 文本：适合于Json数据接收
2. XML结构：直接转化为XML的DOM对象

