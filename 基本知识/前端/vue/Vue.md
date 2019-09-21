# vue

## Vue安装

1. 安装vue时，node.js版本必须大于8.9
2. vue-cli3.x：npm install -g  @vue/cli
3. vue-cli3.x：npm install -g  @vue/cli-init

## 创建项目

1. vue init webpack my-project

   my-project 是项目名称

2. cd my-project

3. 使用npm start 或者npm run dev启动项目

4. 在浏览器中访问http://localhost:8080

## 模板语法

1. Mustache {{变量}} 只能存在于当行语句中
2. v-once : 只能渲染一次
3. v-html: 解析html结构
4. v-bind: 解析属性中的对象