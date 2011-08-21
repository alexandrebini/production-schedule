package br.tear.cadastro;
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class MaqCadastro extends JFrame{
	
	private JLabel cadastrarMaqLabel, numLabel, codigoLabel, descricaoLabel;
	private JTextField numTextField, codigoTextField;
	private JTextArea descricaoTextArea;
	private JScrollPane scroll;
	private JButton inserirButton;
	
	private Container container;
	private JPanel panel;
	private GridBagLayout layout;
	private GridBagConstraints constraint;
	
	public MaqCadastro(){
		setTitle("Máquinas");
		setSize(300, 330);
		setResizable(false);
		setLocation(350, 200);
		setDefaultCloseOperation(EXIT_ON_CLOSE);
		setVisible(true);
		
		//Label
		cadastrarMaqLabel = new JLabel("Cadastrar Máquinas");
		numLabel = new JLabel("Número");
		codigoLabel = new JLabel("Código");
		descricaoLabel = new JLabel("Descrição");
		
		//TextField
		numTextField = new JTextField();
		numTextField.setBorder(BorderFactory.createLoweredBevelBorder());
		codigoTextField = new JTextField();
		codigoTextField.setBorder(BorderFactory.createLoweredBevelBorder());
		
		//TextArea
		descricaoTextArea = new JTextArea();
		scroll = new JScrollPane(descricaoTextArea);
		scroll.setBorder(BorderFactory.createLoweredBevelBorder());
		
		//Button
		inserirButton = new JButton("Inserir");
		inserirButton.setBorder(BorderFactory.createRaisedBevelBorder());
		
		layout = new GridBagLayout();
		constraint = new GridBagConstraints();
		container = this.getContentPane();
		container.setLayout(layout);
		
		//Panel
		panel = new JPanel();
		panel.setLayout(layout);
		panel.setBorder(BorderFactory.createLoweredBevelBorder());
		
		//Label posição
		constraint.fill = GridBagConstraints.HORIZONTAL;
		constraint.anchor = GridBagConstraints.NORTH;
		constraint.insets = new Insets(15, 20, 0, 10);
		setComponent(cadastrarMaqLabel, 0, 0, 1, 1);
	
		constraint.insets = new Insets(15, 15, 15, 0);
		setComponent(numLabel, 0, 0, 1, 1);
		
		constraint.insets = new Insets(0, 15, 15, 0);
		setComponent(codigoLabel, 1, 0, 1, 1);
		
		constraint.insets = new Insets(0, 15, 15, 0);
		setComponent(descricaoLabel, 2, 0, 1, 1);
		
		//TextField posição
		constraint.ipadx = 80;
		constraint.ipady = 1;
		constraint.insets = new Insets(15, 0, 15, 15);
		setComponent(numTextField, 0, 1, 2, 1);
		
		constraint.insets = new Insets(0, 0, 15, 15);
		setComponent(codigoTextField, 1, 1, 2, 1);
		
		//TextArea posição
		constraint.ipady = 80;
		constraint.insets = new Insets(0, 0, 15, 15);
		setComponent(scroll, 2, 1, 2, 4);
		
		//Panel posição
		constraint.ipadx = 0;
		constraint.ipady = 0;
		constraint.insets = new Insets(10, 20, 15, 20);
		setComponent(panel, 1, 0, 2, 6);
		
		//Button posição
		constraint.ipadx = 40;
		constraint.ipady = 7;
		constraint.fill = GridBagConstraints.NONE;
		constraint.anchor = GridBagConstraints.EAST;
		constraint.insets = new Insets(0, 0, 20, 20);
		setComponent(inserirButton, 2, 0, 1, 1);
		
		//Add
		panel.add(numLabel);
		panel.add(codigoLabel);
		panel.add(descricaoLabel);
		panel.add(numTextField);
		panel.add(codigoTextField);
		panel.add(scroll);
		
		container.add(cadastrarMaqLabel);
		container.add(panel);
		container.add(inserirButton);
	}
	
	private void setComponent(Component component, int row, int column, int weight,
							  int height){
		constraint.gridx = column;
		constraint.gridy = row;
		constraint.weightx = weight;
		constraint.weighty = height;
		layout.setConstraints(component, constraint);
	}
	
	public static void main(String[] args){
		MaqCadastro maquina = new MaqCadastro();
	}
}
