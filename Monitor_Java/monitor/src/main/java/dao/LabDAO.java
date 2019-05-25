/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Laboratorio;

/**
 *
 * @author Aluno
 */
public class LabDAO {
    public List<Laboratorio> getLabs(int idUsuario) {
        String SQL = "SELECT ID_LAB, NOME FROM PEEK_LAB WHERE ID_USUARIO = ?";
        Connection cnx = new Banco().getInstance();
        
        
        
        List<Laboratorio> list = new ArrayList<>();

        try {

            PreparedStatement ps = cnx.prepareStatement(SQL);
            ps.setInt(1, idUsuario);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                // System.out.println(rs);
                list.add(new Laboratorio(rs.getInt("ID_LAB"), rs.getString("NOME"),rs.getString("ANDAR")));                
            }

        } catch (SQLException sqlEx) {
            System.out.print("ERRO SQL0003: ");
            sqlEx.printStackTrace();
        } catch (Exception e) {
            System.out.print("ERRO DESC0001: ");
            e.getMessage();
        } finally {
            try {

                if (!cnx.isClosed()) {

                    cnx.close();

                }
            } catch (SQLException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        return list;
    }
}
