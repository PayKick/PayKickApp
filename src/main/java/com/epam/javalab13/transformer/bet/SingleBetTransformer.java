package com.epam.javalab13.transformer.bet;

import com.epam.javalab13.dao.bet.TotalBetDAO;
import com.epam.javalab13.model.bet.*;
import com.epam.javalab13.model.game.Game;
import com.epam.javalab13.transformer.Transformer;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class SingleBetTransformer implements Transformer<SingleBet> {
    @Override
    public SingleBet getOne(ResultSet rs) throws SQLException {
        SingleBet singleBet = null;

        while (rs.next()) {

            TotalBetDAO totalBetDAO = new TotalBetDAO();
            TotalBet totalBet = totalBetDAO.getTotalBetById(rs.getInt("total_bet_id"));

            singleBet = new SingleBet();
            singleBet.setId(rs.getInt("id"));
            singleBet.setTotalBet(totalBet);
            singleBet.setGame(new Game());//TODO Need GameDAO
            singleBet.setCategory(Category.valueOf(rs.getString("category")));
            singleBet.setCoefficient(rs.getDouble("coefficient"));
            singleBet.setStatus(Status.valueOf(rs.getString("status")));

        }

        return singleBet;
    }

    @Override
    public List<SingleBet> getAll(ResultSet rs) throws SQLException {
        List<SingleBet> singleBets = new ArrayList<>();
        SingleBet singleBet = null;

        while (rs.next()) {


            TotalBetDAO totalBetDAO = new TotalBetDAO();
            TotalBet totalBet = totalBetDAO.getTotalBetById(rs.getInt("total_bet_id"));

            singleBet = new SingleBet();
            singleBet.setId(rs.getInt("id"));
            singleBet.setTotalBet(totalBet);
            singleBet.setGame(new Game());//TODO Need GameDAO
            singleBet.setCategory(Category.valueOf(rs.getString("category")));
            singleBet.setCoefficient(rs.getDouble("coefficient"));
            singleBet.setStatus(Status.valueOf(rs.getString("status")));

            singleBets.add(singleBet);
        }

        return singleBets;
    }
}
