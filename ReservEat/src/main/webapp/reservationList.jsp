<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="dbconn.jsp" %>
<%@ page import="java.sql.*" %>
<%
    String query = "SELECT * FROM CustomerReservation WHERE StoreID = ?";
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        pstmt = conn.prepareStatement(query);
        pstmt.setInt(1, 1); // 사업자의 StoreID를 하드코딩하거나 세션에서 가져올 수 있습니다.
        rs = pstmt.executeQuery();
%>
<table border="1">
    <tr>
        <th>Reservation ID</th>
        <th>User ID</th>
        <th>Reservation Date</th>
        <th>Reservation Time</th>
        <th>Number of People</th>
        <th>Status</th>
        <th>Actions</th>
    </tr>
<%
        while (rs.next()) {
%>
    <tr>
        <td><%= rs.getInt("ReservationID") %></td>
        <td><%= rs.getString("UserID") %></td>
        <td><%= rs.getDate("ReservationDate") %></td>
        <td><%= rs.getTime("ReservationTime") %></td>
        <td><%= rs.getInt("NumberOfPeople") %></td>
        <td><%= rs.getString("Status") %></td>
        <td>
            <form action="updateReservationStatus.jsp" method="post">
                <input type="hidden" name="ReservationID" value="<%= rs.getInt("ReservationID") %>">
                <select name="Status">
                    <option value="Pending">Pending</option>
                    <option value="Confirmed">Confirmed</option>
                    <option value="Cancelled">Cancelled</option>
                </select>
                <input type="submit" value="Update">
            </form>
        </td>
    </tr>
<%
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
</table>