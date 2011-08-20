package br.tear.cadastro;
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class ParametrosAG extends JFrame implements ActionListener{
	
	private JLabel alterarParamLabel, tamPopulacaoLabel, txCruzamentoLabel, 
				   txMutacaoLabel, porcentagem1Label, porcentagem2Label;
	private JTextField tamPopulacaoTextField, txCruzamentoTextField, txMutacaoTextField;
	private JButton salvarAlteracoesButton, restaurarPadraoButton;
	private JPanel panel;
	private Container container;
	private GridBagLayout layout;
	private GridBagConstraints constraint;
			
	public ParametrosAG(JFrame frame){
		setTitle("Parâmetros AG");
		setSize(300, 270);
		setResizable(false);
		setLocation(350, 200);		
		setDefaultCloseOperation(DO_NOTHING_ON_CLOSE);
	}
	
	public void initialize(){
		
		//Label
		alterarParamLabel = new JLabel("Alterar Parâmetros");
		tamPopulacaoLabel = new JLabel("Tamanho da População");
		txCruzamentoLabel = new JLabel("Taxa de Cruzameto");
		txMutacaoLabel = new JLabel("Taxa de Mutação");
		porcentagem1Label = new JLabel("%");
		porcentagem2Label = new JLabel("%");
		
		//TextField
		tamPopulacaoTextField = new JTextField();
		tamPopulacaoTextField.setBorder(BorderFactory.createLoweredBevelBorder());
		txCruzamentoTextField = new JTextField();
		txCruzamentoTextField.setBorder(BorderFactory.createLoweredBevelBorder());
		txMutacaoTextField = new JTextField();
		txMutacaoTextField.setBorder(BorderFactory.createLoweredBevelBorder());
		
		//Button
		salvarAlteracoesButton = new JButton("Salvar Alterações");
		salvarAlteracoesButton.addActionListener(this);
		salvarAlteracoesButton.setBorder(BorderFactory.createRaisedBevelBorder());
		restaurarPadraoButton = new JButton("Restaurar Padrão");
		restaurarPadraoButton.setBorder(BorderFactory.createRaisedBevelBorder());
		
		layout = new GridBagLayout();
		constraint = new GridBagConstraints();
		container = this.getContentPane();
		container.setLayout(layout);		
		
		//Panel
		panel = new JPanel();
		panel.setLayout(layout);
		panel.setBorder(BorderFactory.createLoweredBevelBorder());
		
		//Posicionamento
		constraint.weightx = 1;
		constraint.weighty = 1;
		constraint.insets = new Insets(20, 15, 0, 10);
		setComponent(alterarParamLabel, 1, 1, 1, 1);
		
		constraint.fill = GridBagConstraints.HORIZONTAL;
		constraint.insets = new Insets(10, 20, 10, 20);
		setComponent(panel, 3, 1, 3, 5);
		
		constraint.insets = new Insets(15, 10, 15, 0);
		setComponent(tamPopulacaoLabel, 1, 1, 2, 1);
		
		constraint.insets = new Insets(0, 10, 15, 0);
		constraint.weightx = 0.3;
		setComponent(txCruzamentoLabel, 3, 1, 1, 1);
		setComponent(txMutacaoLabel, 5, 1, 1, 1);
		
		constraint.insets = new Insets(15, 0, 15, 27);
		setComponent(tamPopulacaoTextField, 1, 2, 2, 1);
		
		constraint.insets = new Insets(0, 0, 15, 5);
		constraint.weightx = 0.6;
		setComponent(txCruzamentoTextField, 3, 2, 1, 1);
		setComponent(txMutacaoTextField, 5, 2, 1, 1);
		
		constraint.fill = GridBagConstraints.NONE;
		constraint.weightx = 0.1;
		constraint.insets = new Insets(0, 0, 15, 5);
		setComponent(porcentagem1Label, 3, 3, 1, 1);
		setComponent(porcentagem2Label, 5, 3, 1, 1);
		
		constraint.ipadx = 10;
		constraint.ipady = 5;
		constraint.weightx = 0;
		constraint.insets = new Insets(10, 27, 20, 2);
		setComponent(salvarAlteracoesButton, 9, 1, 1, 1);
		
		constraint.insets = new Insets(10, 2, 20, 30);
		setComponent(restaurarPadraoButton, 9, 2, 1, 1);
		
		//Add
		panel.add(tamPopulacaoLabel);
		panel.add(tamPopulacaoTextField);
		panel.add(txCruzamentoLabel);
		panel.add(txCruzamentoTextField);
		panel.add(porcentagem1Label);
		panel.add(txMutacaoLabel);
		panel.add(txMutacaoTextField);
		panel.add(porcentagem2Label);
		
		container.add(alterarParamLabel);
		container.add(panel);
		container.add(salvarAlteracoesButton);
		container.add(restaurarPadraoButton);
		
		setVisible(true);
	}
	
	private void setComponent(Component component, int row, int column,
            int width, int height){
		constraint.gridx = column;
		constraint.gridy = row;
		constraint.gridwidth = width;
		constraint.gridheight = height;
		layout.setConstraints(component, constraint);
	}
	
	//public static void main(String[] args){
	//	ParametrosAG frame = new ParametrosAG();
	//}

	public void actionPerformed(ActionEvent ae) {
		// TODO Auto-generated method stub
		
		if( ae.getSource() == salvarAlteracoesButton )
        {
			setVisible(false);
        }
	}
}