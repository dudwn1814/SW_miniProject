package com.mini.project;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


@WebServlet(name = "mView", urlPatterns = {"/board/mView"})
public class miniBoardView extends HttpServlet {
  private static final long serialVersionUID = 1L;

  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {

    final Logger logger = LoggerFactory.getLogger(miniBoardView.class);

    logger.info("===== mView start =====");
    resp.setContentType("text/html; charset=UTF-8");

    String uri = "jdbc:mariadb://127.0.0.1:3306/inventory";
    String userid = "webmaster";
    String userpw = "1234";

    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;

    Map<String, Object> map = new HashMap<String, Object>();

    String p_id = req.getParameter("p_id");

    String query = "select p_id, p_name, p_price, p_amount from inventory_management "
        + "where p_id = " + p_id;

    logger.info("게시물 내용 보기 실행 쿼리문 : {}", query);

    try {
      // DataSource ds = (DataSource) this.getServletContext().getAttribute("dataSource");
      // con = ds.getConnection();

      Class.forName("org.mariadb.jdbc.Driver");
      con = DriverManager.getConnection(uri, userid, userpw);

      stmt = con.createStatement();
      rs = stmt.executeQuery(query);

      if (rs.next()) {
        map.put("p_id", rs.getInt("p_id"));
        map.put("p_name", rs.getString("p_name"));
        map.put("p_price", rs.getInt("p_price"));
        map.put("p_amount", rs.getInt("p_amount"));
      }

      req.setAttribute("list", map);
      logger.info("list : {}", map);

      RequestDispatcher dispatcher = req.getRequestDispatcher("/board/mView.jsp");
      dispatcher.forward(req, resp);

      if (rs != null) {
        rs.close();
      }
      if (stmt != null) {
        stmt.close();
      }
      if (con != null) {
        con.close();
      }

    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  protected void doPost(HttpServletRequest request, HttpServletResponse response)
      throws ServletException, IOException {


  }

}
