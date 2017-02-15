package com.jshpsoft.websocket;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

/**
 * 
 * @Description:  配置websocket
 * @author army.liu
 * @date 2016年10月31日 下午1:58:08
 *
 */
@Configuration
@EnableWebMvc
@EnableWebSocket
public class WebSocketConfig extends WebMvcConfigurerAdapter implements WebSocketConfigurer {
	
	private static Logger logger = LoggerFactory.getLogger(WebSocketConfig.class);
	 
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		logger.debug("websocket register.....");
        registry.addHandler( getSystemWebSocketHandler(), "/webSocketServer" ).addInterceptors(new WebSocketHandshakeInterceptor());
        registry.addHandler( getSystemWebSocketHandler(), "/sockjs/webSocketServer" ).addInterceptors(new WebSocketHandshakeInterceptor()).withSockJS();
		
	}

	public WebSocketHandler getSystemWebSocketHandler(){
		return new SystemWebSocketHandler();
	}
}
