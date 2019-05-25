package aplicacao;

import controller.ComputadorController;
import controller.NotificacaoController;
import controller.RedeController;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Scanner;
import view.JanelaLogin;
import view.JanelaModelIniciandoMonitoramento;
import view.JanelaNotificacao;

public class App {

    public static void main(String[] args) throws InterruptedException, SQLException, IOException {
        
        if (new ComputadorController().isPcJaCadastrado(new RedeController().getMacsPC())) {
            new JanelaModelIniciandoMonitoramento();
            new log_Monet.ArquivoLogger("login automatico, computador já cadastrado");
            new ComputadorController().coletarInformacoes();
            new NotificacaoController().iniciarSistema();

        } else {
            new JanelaLogin();
            new log_Monet.ArquivoLogger("abrindo tela de login");
        }
    }
}
