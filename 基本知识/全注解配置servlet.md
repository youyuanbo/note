# 全注解配置servlet

## 依赖

servlet-api，Spring-web，Spring-webmvc，Spring-context， Spring-core

新建一个初始化类

```java
package com.xiaoyou.initializer;

import com.xiaoyou.config.RootConfig;
import com.xiaoyou.config.WebConfig;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class MyWebAppInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {
	//指定Root配置类位置，Root配置类主要负责service与repository
    @Override
    protected Class<?>[] getRootConfigClasses() {
        return new Class[]{RootConfig.class};
    }
	
    //指定web配置类位置，web配置类主要负责controller
    @Override
    protected Class<?>[] getServletConfigClasses() {
        return new Class[]{WebConfig.class};
    }
	
    //指定拦截范围，“/”代表拦截所有请求，不拦截jsp
    //“/*”也是拦截所有请求，包括jsp
    @Override
    protected String[] getServletMappings() {
        return new String[]{"/"};
    }
}
```



RootConfig类

```java
package com.xiaoyou.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.FilterType;
import org.springframework.stereotype.Controller;

//不扫描controller
@Configuration
@ComponentScan(value = "com.xiaoyou", excludeFilters = {@ComponentScan.Filter(type = FilterType.ANNOTATION, classes = Controller.class)})
public class RootConfig {
}
```



WebConfig类

```java
@Configuration
@EnableWebMvc
//只扫描controller
@ComponentScan(value = "com.xiaoyou", includeFilters = {@ComponentScan.Filter(type = FilterType.ANNOTATION, value = {Controller.class})},useDefaultFilters = false)
public class WebConfig implements WebMvcConfigurer {}
```

在WebConfig类中，可以添加视图解析器等配置



其他代码编辑，与使用web.xml配置一样



