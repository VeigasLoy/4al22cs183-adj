
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

@WebServlet("/prime")
public class PrimeServlet extends HttpServlet {
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    response.setContentType("text/html");
    PrintWriter out = response.getWriter();

    try {
      int number = Integer.parseInt(request.getParameter("number"));
      boolean isPrime = true;

      if (number <= 1) {
        isPrime = false;
      } else {
        for (int i = 2; i <= Math.sqrt(number); i++) {
          if (number % i == 0) {
            isPrime = false;
            break;
          }
        }
      }

      out.println("<html><body>");
      out.println("<h2>Result:</h2>");
      out.println("<p>The number <strong>" + number + "</strong> is " + (isPrime ? "a prime number." : "not a prime number.") + "</p>");
      out.println("<a href='index.html'>Check another number</a>");
      out.println("</body></html>");
    } catch (NumberFormatException e) {
      out.println("<p style='color:red;'>Please enter a valid number.</p>");
    }
  }

  protected void doGet(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {
    response.sendRedirect("index.html");
  }
}
