package dto.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class CheckLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            System.out.println("Session ID: " + session.getId());
            if (session.getAttribute("storeID") != null) {
                System.out.println("Store logged in with ID: " + session.getAttribute("storeID"));
                response.getWriter().print("storeLoggedIn");
            } else if (session.getAttribute("userID") != null) {
                System.out.println("User logged in with ID: " + session.getAttribute("userID"));
                response.getWriter().print("userLoggedIn");
            } else {
                System.out.println("No user or store logged in.");
                response.getWriter().print("notLoggedIn");
            }
        } else {
            System.out.println("No session found.");
            response.getWriter().print("notLoggedIn");
        }
    }
}
