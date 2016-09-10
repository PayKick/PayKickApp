package com.epam.javalab13.servlet;

import com.epam.javalab13.dao.bet.TotalBetDAO;
import com.epam.javalab13.model.User;
import com.epam.javalab13.model.bet.TotalBet;
import com.epam.javalab13.model.game.Team;
import com.epam.javalab13.service.game.TeamService;
import com.google.gson.Gson;
import org.apache.log4j.Logger;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

/**
 * Created by Olga on 02.09.2016.
 */
public class ChartServlet extends HttpServlet {
    private static Logger logger = Logger.getLogger(ChartServlet.class);
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher requestDispatcher;
        requestDispatcher = req.getRequestDispatcher("chart.jsp");
        requestDispatcher.forward(req, resp);
    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        TeamService teamService=new TeamService();
        TotalBetDAO totalBetDAO = new TotalBetDAO();

        String chartType=req.getParameter("type");
        Gson gson = new Gson();
        String json="";

        if (chartType!=null){
            switch (chartType){
                case "user_bat":
                    List<TotalBet> allBets;
                    try {

                        User user=new User();
                        if (req.getParameter("id")!=null){
                            user.setId(Integer.valueOf(req.getParameter("id")));
                        }

                        allBets = totalBetDAO.getTotalBetsForUser(TotalBetDAO.GetTotalBetsType.ALL, user);
                        json = gson.toJson(allBets);
                    } catch (SQLException e) {
                        logger.warn("Exception while getting all TotalBets:",e);
                    }
                    break;
                case "team_win":
                    Team team=new Team();
                    team.setName("Динамо");
                    Team resultTeam=null;
                    try {
                        resultTeam=teamService.getTeamByName(team);
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    json = gson.toJson(resultTeam);
                    break;
                case "all_bats":
                    List<TotalBet> all;
                    try {
                        all = totalBetDAO.getAllTotalBets(TotalBetDAO.GetTotalBetsType.ALL);
                        Collections.sort(all);
                        json = gson.toJson(all);
                    } catch (SQLException e) {
                        logger.warn("Exception while getting all TotalBets:",e);
                    }
            }
        }
        resp.setContentType("application/json");// set content to json
        resp.getWriter().write(json);
    }
}
