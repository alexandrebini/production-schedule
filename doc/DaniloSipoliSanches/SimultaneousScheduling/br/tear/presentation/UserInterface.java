/*
 * Interface principal da aplica��o
 * Atrav�s dela s�o chamados as demais telas do sistema.
 */

package br.tear.presentation;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JFrame;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;

import br.tear.cadastro.Cadastro;
import br.tear.cadastro.MaqCadastro;
import br.tear.cadastro.ParametrosAG;
import br.tear.cadastro.ProdCadastro;
import br.tear.cadastro.ProgProducao;

class UserInterface extends JFrame implements ActionListener {

	JMenuBar menu = new JMenuBar();

	JMenu cadastro = new JMenu("Cadastro");
	JMenuItem operationTime = new JMenuItem("Tempo de Opera��o");
	JMenuItem produto = new JMenuItem("Produtos");
	JMenuItem maquina = new JMenuItem("M�quinas");
	JMenuItem rot = new JMenuItem("Roteiros");

	JMenu gerarPrograma = new JMenu("Programar Produ��o");
	JMenuItem gerar = new JMenuItem("Gerar Programa��o");

	JMenu parametros = new JMenu("Par�metros AG");
	JMenuItem ag = new JMenuItem("Ajustar Par�metros");

	Cadastro cad;
	MaqCadastro maq;
	ProdCadastro prod;
	ProgProducao prog;
	ParametrosAG paramAG;
	RouteInterface route;

	private static void createAndShowGUI() {

		JFrame frame = new JFrame();

		final UserInterface userInterface = new UserInterface(frame);
	}

	public UserInterface(JFrame frame) {

		super("Programador da Produ��o");

		setDefaultCloseOperation(EXIT_ON_CLOSE);

		setResizable(false);

		setSize(800, 600);

		setResizable(false);

		prog = new ProgProducao(frame);

		paramAG = new ParametrosAG(frame);

		// Cria os menus
		cadastro.add(operationTime);
		cadastro.add(produto);
		cadastro.add(maquina);
		cadastro.add(rot);
		operationTime.addActionListener(this);
		produto.addActionListener(this);
		maquina.addActionListener(this);
		rot.addActionListener(this);

		gerarPrograma.add(gerar);
		gerar.addActionListener(this);

		parametros.add(ag);
		ag.addActionListener(this);

		// Adiciona os Menus na aplica��o
		menu.add(cadastro);
		menu.add(gerarPrograma);
		menu.add(parametros);
		setJMenuBar(menu);

		cad = new Cadastro(frame);
		prod = new ProdCadastro(frame);
		route = new RouteInterface(frame);

		// Deixa a interface vis�vel
		setVisible(true);
	}

	// Verifica qual evento foi emitido
	public void actionPerformed(ActionEvent ae) {
		if (ae.getSource() == operationTime) {
			cad.initialize();
			cad.showCadastro();
		} else if (ae.getSource() == rot) {
			route.initialize();
			route.showRouteInterface();
		} else if (ae.getSource() == produto) {
			prod.Initialize();
			prod.setVisible(true);
			// route.showRouteInterface();
		} else if (ae.getSource() == rot) {
			route.initialize();
			route.showRouteInterface();
		} else if (ae.getSource() == gerar) {
			prog.initialize();
			prog.setVisible(true);
		} else if (ae.getSource() == ag) {
			paramAG.initialize();
		} else if (ae.getSource() == maquina) {
			maq.setVisible(true);
		}
	}

	// Executa a aplica��o
	public static void main(String[] args) {
		// Schedule a job for the event-dispatching thread:
		// creating and showing this application's GUI.
		javax.swing.SwingUtilities.invokeLater(new Runnable() {
			public void run() {

				createAndShowGUI();
			}
		});
	}

}
