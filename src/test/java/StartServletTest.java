import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.project.StartServlet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class StartServletTest {
    @Test
    void testDoPostExploreAction() throws IOException {
        HttpServletRequest mockRequest = Mockito.mock(HttpServletRequest.class);
        HttpServletResponse mockResponse = Mockito.mock(HttpServletResponse.class);
        HttpSession mockSession = Mockito.mock(HttpSession.class);

        when(mockRequest.getSession()).thenReturn(mockSession);
        when(mockSession.getAttribute("health")).thenReturn(100);
        when(mockSession.getAttribute("foodFound")).thenReturn(false);
        when(mockSession.getAttribute("keyFound")).thenReturn(false);
        when(mockSession.getAttribute("toolFound")).thenReturn(false);
        when(mockSession.getAttribute("portalFound")).thenReturn(false);
        when(mockSession.getAttribute("userName")).thenReturn("TestUserName"); // устанавливаем имя пользователя

        StartServlet servlet = new StartServlet();

        servlet.doPost(mockRequest, mockResponse);

        assertEquals("TestUserName", mockSession.getAttribute("userName"));
        assertEquals(100, (int) mockSession.getAttribute("health"));
    }
}
