package br.tear.cadastro;
import javax.swing.*;

import br.tear.presentation.TestGenerate;

import java.awt.*;
import java.awt.event.*;
import java.io.IOException;


public class ProgProducao extends JFrame implements ActionListener{
	
	private JLabel progLabel, makespanLabel, tempoLabel;
	private JTextField progTextField, makespanTextField, tempoTextField;
	private JButton gerarProgButton, ganttButton;
	
	private Container container;
	private JPanel progPanel, ganttPanel;
	private GridBagLayout layout;
	private GridBagConstraints constraint;
	
	public ProgProducao(JFrame frame){
		setTitle("Programar Produção");
		setSize(600, 300);
		setResizable(false);
		setLocation(270, 200);
		setDefaultCloseOperation(DO_NOTHING_ON_CLOSE);
	}	
		
	public void initialize(){		
		//Label
		progLabel = new JLabel("Melhor Solução");
		makespanLabel = new JLabel("Makespan");
		tempoLabel = new JLabel("Tempo");
		
		//TextField
		progTextField = new JTextField(20);
		progTextField.setBorder(BorderFactory.createLoweredBevelBorder());
		makespanTextField = new JTextField(8);
		makespanTextField.setBorder(BorderFactory.createLoweredBevelBorder());
		tempoTextField = new JTextField(4);
		tempoTextField.setBorder(BorderFactory.createLoweredBevelBorder());
		
		//Button
		gerarProgButton = new JButton("Gerar Programação");
		gerarProgButton.addActionListener(this);
		gerarProgButton.setBorder(BorderFactory.createRaisedBevelBorder());
		ganttButton = new JButton("Gantt");
		ganttButton.addActionListener(this);
		ganttButton.setBorder(BorderFactory.createRaisedBevelBorder());
		
		layout = new GridBagLayout();
		constraint = new GridBagConstraints();
		container = this.getContentPane();
		container.setLayout(layout);
		
		//Panel
		progPanel = new JPanel();
		progPanel.setLayout(layout);
		progPanel.setBorder(BorderFactory.createLoweredBevelBorder());
		ganttPanel = new JPanel();
		ganttPanel.setLayout(layout);
		ganttPanel.setBorder(BorderFactory.createLoweredBevelBorder());
		
		//Label posição
		constraint.fill = GridBagConstraints.NONE;
		constraint.anchor = GridBagConstraints.WEST;
		constraint.insets = new Insets(15, 0, 10, 0);
		setComponent(progLabel, 0, 1, 1, 1);
		
		constraint.insets = new Insets(0, 0, 10, 0);
		setComponent(makespanLabel, 1, 1, 1, 1);
		
		constraint.insets = new Insets(0, 0, 10, 0);
		setComponent(tempoLabel, 2, 1, 1, 1);
		
		//TextField posição
		constraint.fill = GridBagConstraints.HORIZONTAL;
		constraint.insets = new Insets(15, 0, 15, 15);
		setComponent(progTextField, 0, 2, 2, 1);
		
		constraint.insets = new Insets(0, 0, 15, 15);
		setComponent(makespanTextField, 1, 2, 2, 1);
		
		constraint.insets = new Insets(0, 0, 15, 15);
		setComponent(tempoTextField, 2, 2, 2, 1);
		
		//Panel posição
		constraint.fill = GridBagConstraints.BOTH;
		constraint.weightx = 1;
		constraint.insets = new Insets(20, 20, 20, 20);
		setComponent(progPanel, 0, 0, 3, 3);
		
		constraint.insets = new Insets(0, 20, 20, 20);
		setComponent(ganttPanel, 1, 0, 3, 1);
		
		//Button posição
		constraint.ipadx = 30;
		constraint.ipady = 7;
		constraint.fill = GridBagConstraints.NONE;
		constraint.anchor = GridBagConstraints.NORTHWEST;
		constraint.insets = new Insets(15, 15, 15, 0);
		setComponent(gerarProgButton, 0, 0, 1, 1);
		
		constraint.anchor = GridBagConstraints.CENTER;
		constraint.insets = new Insets(10, 0, 10, 0);
		setComponent(ganttButton, 0, 1, 1, 1);
		
		//Add
		progPanel.add(progLabel);
		progPanel.add(makespanLabel);
		progPanel.add(tempoLabel);
		progPanel.add(progTextField);
		progPanel.add(makespanTextField);
		progPanel.add(tempoTextField);
		progPanel.add(gerarProgButton);
		ganttPanel.add(ganttButton);
		
		container.add(progPanel);
		container.add(ganttPanel);
		
		setVisible(true);
	}
	
	private void setComponent(Component component, int row, int column,
            				  int weight, int height){
		constraint.gridx = column;
		constraint.gridy = row;
		constraint.weightx = weight;
		constraint.weighty = height;
		layout.setConstraints(component, constraint);
	}

	public void actionPerformed(ActionEvent ae) {
		// TODO Auto-generated method stub
		if( ae.getSource() == ganttButton )
        {
        	       	
        	setVisible(false);
        }
		if(ae.getSource() == gerarProgButton){
//			Teste teste2 = new Teste();
			try {
				TestGenerate teste = new TestGenerate();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	//public static void main(String[] args){
	//	ProgProducao frameProg = new ProgProducao();
	//}
}
