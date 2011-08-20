package br.tear.cadastro;

import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;

public class Cadastro extends JDialog implements ActionListener {

	private OperationTime op;

	private Maquina maquina;

	private Produto produto;
	
	private AGVCad agv;

	private JButton okButton;

	private JButton saveButton;

	private JTextField textProduct;

	private JTextField textMachine;

	private JTextField textOperationTime;

	private JLabel labelProduct;

	private JLabel labelMachine;

	private JLabel labelOperationTime;

	public Cadastro(JFrame frame) {
		super(frame, true);

		setTitle("Tempos de Operação");

		setDefaultCloseOperation(DO_NOTHING_ON_CLOSE);

		setResizable(false);

		setSize(300, 200);

		op = new OperationTime();

		maquina = new Maquina();

		produto = new Produto();
		
		agv = new AGVCad();
		
				
		/* Cria qtde de Maquinas e Produtos */
		/*for (int i = 1; i <6; i++)
			produto.setNumProd(i);

		for (int m = 1; m <7; m++)
			maquina.setNumMaq(m);
		*/
		/*
		 * Informa a qtde de AGVs
		 */
		//agv.setAgvNumber(2);

	}

	public void initialize() {

		JPanel panel = new JPanel(new GridBagLayout());

		GridBagConstraints c = new GridBagConstraints();
		c.fill = GridBagConstraints.HORIZONTAL;

		c.gridx = 0;
		c.gridy = 0;
		labelProduct = new JLabel("Nr. Produto:");
		panel.add(labelProduct, c);

		c.gridx = 1;
		c.gridy = 0;
		textProduct = new JTextField(6);
		panel.add(textProduct, c);

		c.gridx = 0;
		c.gridy = 1;
		labelMachine = new JLabel("Nr. Maquina:");
		panel.add(labelMachine, c);

		c.gridx = 1;
		c.gridy = 1;
		textMachine = new JTextField(6);
		panel.add(textMachine, c);

		c.gridx = 0;
		c.gridy = 2;
		labelOperationTime = new JLabel("Tempo de Operação:");
		panel.add(labelOperationTime, c);

		c.gridx = 1;
		c.gridy = 2;
		textOperationTime = new JTextField(6);
		panel.add(textOperationTime, c);

		c.gridx = 1;
		c.gridy = 3;
		okButton = new JButton("OK");
		panel.add(okButton, c);
		okButton.addActionListener(this);

		c.gridx = 0;
		c.gridy = 3;
		saveButton = new JButton("Adicionar");
		panel.add(saveButton, c);
		saveButton.addActionListener(this);

		setContentPane(panel);

	}

	@SuppressWarnings("deprecation")
	public void actionPerformed(ActionEvent ev) {
		// TODO Auto-generated method stub
		if (ev.getSource() == saveButton) {
			op.setTempo(Integer.parseInt(textProduct.getText()), Integer
					.parseInt(textMachine.getText()), Integer
					.parseInt(textOperationTime.getText()));
			clearAll();
		}
		if (ev.getSource() == okButton) {
			setVisible(false);
		}
	}

	public void clearAll() {
		textProduct.setText("");
		textMachine.setText("");
		textOperationTime.setText("");
	}

	public void showCadastro() {
		setVisible(true);
	}

}
