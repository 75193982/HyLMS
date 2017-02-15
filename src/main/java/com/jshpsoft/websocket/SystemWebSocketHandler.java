package com.jshpsoft.websocket;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;

import com.jshpsoft.util.Constants;

/**
 * @Description: handler处理类
 * @author army.liu
 * @date 2016年10月31日 上午9:20:04
 *
 */
public class SystemWebSocketHandler implements WebSocketHandler, ApplicationContextAware  {

    private static final Logger logger;

    private static final Map<String, WebSocketSession> users;

    static {
        users = new HashMap<String, WebSocketSession>();
        logger = LoggerFactory.getLogger(SystemWebSocketHandler.class);
    }

    /**
     * 连接建立后处理：将该用户最新的未读消息数目返回
     */
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
    	logger.debug("connect to websocket server success......");
    	
    	String userId = (String) session.getAttributes().get(Constants.WEBSOCKET_USER);
    	if( users.containsKey(userId) ){
    		WebSocketSession oldSession = users.get(userId);
    		if( oldSession.isOpen() ){
    			
    			synchronized (oldSession) {//试图解决：【http://stackoverflow.com/questions/29002063/websocket-the-remote-endpoint-was-in-state-text-partial-writing】The remote endpoint was in state [TEXT_PARTIAL_WRITING] which is an invalid state for called method
    				users.get(userId).sendMessage( new TextMessage( Constants.FORCE_LOGIN_OUT ) );
					
				}
    			
    		}
            
    	}
    	users.put(userId, session);
        
//        if( StringUtils.isNotEmpty(userId) ){
//        	MessageService messageService = (MessageService) getBean("messageService");
//            //查询未读消息
//            int count = messageService.getUnReadMsgCount( Integer.parseInt(userId) );
//            session.sendMessage(new TextMessage(""+count + ""));
//            
//        }
        
    }

    @Override
    public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
    	logger.debug( "用户["+(String) session.getAttributes().get(Constants.WEBSOCKET_USER)+"] 调用:" + message );
    	
    	
    }

    /**
     * 抛出异常时处理
     */
    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
        if( session.isOpen() ){
            session.close();
        }
        logger.debug("websocket connection error......");
        users.remove(session);
    }

    /**
     * 连接关闭后处理
     */
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus closeStatus) throws Exception {
        logger.debug("websocket connection closed......");
        users.remove(session);
    }

    @Override
    public boolean supportsPartialMessages() {
        return false;
    }

    /**
     * 给所有在线用户发送消息
     *
     * @param message
     */
    public void sendMessageToUsers(TextMessage message) {
    	Set<Entry<String, WebSocketSession>> entrySet = users.entrySet();
    	for(Entry<String, WebSocketSession> entry : entrySet ){
    		WebSocketSession user = entry.getValue();
    		try {
                if (user.isOpen()) {
                    user.sendMessage(message);
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
    	}
    }

    /**
     * 给某个用户发送消息
     *
     * @param userName
     * @param message
     */
    public void sendMessageToUser(String userId, TextMessage message) {
    	Set<Entry<String, WebSocketSession>> entrySet = users.entrySet();
    	for(Entry<String, WebSocketSession> entry : entrySet ){
    		String userIdInMap = entry.getKey();
            if ( userIdInMap.equals(userId) ) {
            	WebSocketSession user = entry.getValue();
                try {
                    if (user.isOpen()) {
                        user.sendMessage(message);
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
                break;
            }
        }
    }

	private static ApplicationContext applicationContext;
	
	@SuppressWarnings("static-access")
	@Override
	public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
		this.applicationContext = applicationContext;
	}
	
	public static Object getBean(String name){
		applicationContext.getBeanDefinitionNames();
		return applicationContext.getBean(name);
	} 

}
