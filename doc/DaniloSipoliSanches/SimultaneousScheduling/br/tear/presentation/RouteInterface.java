package br.tear.presentation;

import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;

import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;

import br.tear.cadastro.Maquina;
import br.tear.cadastro.Produto;
import br.tear.cadastro.Roteiro;
import br.tear.cadastro.Teste;


public class RouteInterface extends JDialog implements ActionListener{

	/**
	 * 
	 */
	private static final long serialVersionUID = 525950265188367459L;
	
	private JButton okButton;
	private JButton saveButton;
	private JButton gerarPrograma;	
	private JTextField textRouteNumber;
	private JTextField textRoute;	
	private JComboBox productCombo;
	private JComboBox machineCombo;
	private JLabel labelProduct;
	private JLabel labelRoute;
	private JLabel labelRouteNumber;
	private JLabel labelNumberProduct;
	private JLabel labelMachine;
	
	private Roteiro roteiro;
	
	private Produto produto;
	
	private Maquina maquina;
	
	private int codigo, prod;
	
	private String[] prods = {"0","1","2","3","4","5"};
	
	private String[] maqs = {"0","1","2","3","4","5","6","7","8"};
	
	
	public RouteInterface(JFrame frame){
		super(frame,true);
		
		setTitle("Gerador de Roteiros");
		
		setDefaultCloseOperation(DO_NOTHING_ON_CLOSE);
				
		setResizable(false);
		
		setSize(300,200);
		
		roteiro = new Roteiro();
		
		produto = new Produto();
		
		maquina = new Maquina();
							
	}
	
	/*
	 * Metodo respons�vel pela cria��o da interface
	 * dos cadastros de roteiros
	 */
	public void initialize(){
		
		JPanel panel = new JPanel(new GridBagLayout());

		GridBagConstraints c = new GridBagConstraints();
		c.fill = GridBagConstraints.HORIZONTAL;
		
		c.gridx=0;
		c.gridy=0;
		labelProduct = new JLabel("Nr. Produto:");
		panel.add(labelProduct,c);
		
		c.gridx=1;
		c.gridy=0;
		productCombo = new JComboBox(prods);
		productCombo.addActionListener(this);		
		//productCombo.setSelectedIndex(0);
		panel.add(productCombo,c);
		
		c.gridx=0;
		c.gridy=1;
		labelRouteNumber = new JLabel("Nr. Roteiro:");
		panel.add(labelRouteNumber,c);
		
		c.gridx=1;
		c.gridy=1;
		textRouteNumber = new JTextField(6);
		panel.add(textRouteNumber,c);
		
		c.gridx=0;
		c.gridy=2;
		labelMachine = new JLabel("Nr. Maquina:");
		panel.add(labelMachine,c);
		
		c.gridx=1;
		c.gridy=2;
		machineCombo = new JComboBox(maqs);
		machineCombo.addActionListener(this);
		//machineCombo.setSelectedIndex(0);
		panel.add(machineCombo,c);
		
		c.gridx=0;
		c.gridy=3;
		labelRoute = new JLabel("Roteiro:");
		panel.add(labelRoute,c);
		
		c.gridx=1;
		c.gridy=3;
		textRoute = new JTextField(6);
		panel.add(textRoute,c);
							
		c.gridx=0;
		c.gridy=4;
		saveButton = new JButton("Adicionar");
		panel.add(saveButton,c);
		saveButton.addActionListener(this);
		
		/*c.gridx=1;
		c.gridy=4;
		gerarPrograma = new JButton("Gerar Programa��o");
		panel.add(gerarPrograma,c);
		gerarPrograma.addActionListener(this);*/
		
		c.gridx=1;
		c.gridy=4;
		okButton = new JButton("Sair");
		panel.add(okButton,c);
		okButton.addActionListener(this);
		
		setContentPane(panel);
				
	}
	
	
	/*
	 * Verifica qual evento foi emitido
	 */
	@SuppressWarnings("deprecation")
	public void actionPerformed(ActionEvent ev) {
		// TODO Auto-generated method stub
		if(ev.getSource()==saveButton){
			codigo = Integer.parseInt(String.valueOf(prod) + textRouteNumber.getText());
			roteiro.setRoute(codigo,textRoute.getText());
			produto.setRoteiro(prod);			
			clearAll();
		}
		
		if(ev.getSource() == productCombo){			
			JComboBox cb = (JComboBox) ev.getSource();
			prod = cb.getSelectedIndex();						
		}
				
		if(ev.getSource() == machineCombo){			
			JComboBox cb = (JComboBox) ev.getSource();
			String temp = textRoute.getText();
			textRoute.setText(temp + String.valueOf(cb.getSelectedIndex()));			
		}
		if(ev.getSource() == gerarPrograma){
			Teste teste2 = new Teste();
			try {
				TestGenerate teste = new TestGenerate();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}			
		}
		if(ev.getSource() == okButton){			
			setVisible(false);			
		}				
	}
	
	/*
	 * Ap�s o cadastro, todos os campos s�o limpados
	 */
	public void clearAll(){
		codigo = 0;
		productCombo.setSelectedIndex(0);
		machineCombo.setSelectedIndex(0);
		textRouteNumber.setText("");
		textRoute.setText("");		
	}
	
	public void showRouteInterface(){
		setVisible(true);
	}

}
