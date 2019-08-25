# Shiro安全框架

## 依赖

```xml
<dependency>
  <groupId>org.apache.shiro</groupId>
  <artifactId>shiro-spring</artifactId>
  <version>1.4.1</version>
</dependency>

<dependency>
  <groupId>org.apache.shiro</groupId>
  <artifactId>shiro-spring-boot-starter</artifactId>
  <version>1.4.1</version>
</dependency>
<!-与springboot集成-->
<dependency>
  <groupId>org.apache.shiro</groupId>
  <artifactId>shiro-spring-boot-web-starter</artifactId>
  <version>1.4.1</version>
</dependency>
```

## springboot与Shiro集成

### 添加依赖

```xml
<dependency>
  <groupId>org.apache.shiro</groupId>
  <artifactId>shiro-spring</artifactId>
  <version>1.4.1</version>
</dependency>

```

### 创建一个类ShiroRealm

用于编写认证与授权逻辑

```java
package com.cdtu.shiro.shiro;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

public class ShiroRealm extends AuthorizingRealm {

	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
		//编写授权逻辑
		return null;
	}

	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
		//编写认证逻辑
		return null;
	}
}

```

### 创建Shiro的配置类ShiroConfig

在类中需要做如下配置：

1. 配置ShiroRealm
   + 返回一个Realm对象

2. 配置SecurityManager
   + 返回一个DefaultWebSecurityManager对象

3. 配置ShiroFilterFactoryBean
   + 返回一个ShiroFilterFactoryBean对象
   + 配置拦截的请求，以及不拦截的请求

```java
package com.cdtu.shiro.config;

import com.cdtu.shiro.shiro.ShiroRealm;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.LinkedHashMap;

@Configuration
public class ShiroConfig {

	//1、配置ShiroFilterFactoryBean
	@Bean
	public ShiroFilterFactoryBean shiroFilterFactoryBean(SecurityManager securityManager){
		ShiroFilterFactoryBean shiroFilterFactoryBean = new ShiroFilterFactoryBean();
		shiroFilterFactoryBean.setSecurityManager(securityManager);
		shiroFilterFactoryBean.setLoginUrl("/toLogin");
		shiroFilterFactoryBean.setSuccessUrl("/index");
		shiroFilterFactoryBean.setUnauthorizedUrl("/403");

		LinkedHashMap<String, String> filterChainDefinitionMap = new LinkedHashMap<>();
		//拦截所有请求
		filterChainDefinitionMap.put("/*", "authc");


		shiroFilterFactoryBean.setFilterChainDefinitionMap(filterChainDefinitionMap);

		return shiroFilterFactoryBean;
	}


	//2、配置SecurityManager
	@Bean
	public SecurityManager securityManager(ShiroRealm shiroRealm){
		DefaultWebSecurityManager defaultWebSecurityManager = new DefaultWebSecurityManager();
		defaultWebSecurityManager.setRealm(shiroRealm);
		return defaultWebSecurityManager;
	}

	//3、配置自定义的Realm

	@Bean
	public ShiroRealm shiroRealm(){
		return new ShiroRealm();
	}
}

```

## Shiro常见的异常

```java
DisabledAccountException //账户失效异常
ExcessiveAttemptsException;	//尝试次数过多
UnknownAccountException;	//用户不正确
ExpiredCredentialsException;	//凭证过期异常
IncorrectCredentialsException;	//凭证不正确
```