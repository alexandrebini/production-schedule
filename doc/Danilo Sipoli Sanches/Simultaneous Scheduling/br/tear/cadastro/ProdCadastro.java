package br.tear.cadastro;
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class ProdCadastro extends JFrame implements ActionListener{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -3390373986875323337L;
	private JLabel cadastrarProdLabel, prodLabel, descricaoLabel, tamLoteLabel;
	private JTextField prodTextField, tamLoteTextField;
	private JTextArea descricaoTextArea;
	private JScrollPane scroll;
	private JButton salvarButton, cadRoteiroButton;
	
	private Container container;
	private JPanel principalPanel, botaoPanel;
	private GridBagLayout layout;
	private GridBagConstraints constraint;
	
	public ProdCadastro(JFrame frame){
		//super(frame,true);
		setTitle("Produtos");
		setSize(350, 400);
		setResizable(false);
		setLocation(350, 200);
		setDefaultCloseOperation(DO_NOTHING_ON_CLOSE);
		
	}
	
	public void Initialize(){
				
		//Label
		cadastrarProdLabel = new JLabel("Cadastrar Produto");
		prodLabel = new JLabel("Produto");
		descricaoLabel = new JLabel("Descrição");
		tamLoteLabel = new JLabel("Tamanho do Lote");
		
		//TextField
		prodTextField = new JTextField();
		prodTextField.setBorder(BorderFactory.createLoweredBevelBorder());
		tamLoteTextField = new JTextField();
		tamLoteTextField.setBorder(BorderFactory.createLoweredBevelBorder());
				
		//TextArea
		descricaoTextArea = new JTextArea();
		scroll = new JScrollPane(descricaoTextArea);
		scroll.setBorder(BorderFactory.createLoweredBevelBorder());
		
		//Button
		salvarButton = new JButton("Salvar");
		salvarButton.setBorder(BorderFactory.createRaisedBevelBorder());
		salvarButton.addActionListener(this);
		cadRoteiroButton = new JButton("Cadastrar Roteiro");
		cadRoteiroButton.setBorder(BorderFactory.createRaisedBevelBorder());
		
		layout = new GridBagLayout();
		constraint = new GridBagConstraints();
		container = this.getContentPane();
		container.setLayout(layout);
		
		//Panel
		principalPanel = new JPanel();
		principalPanel.setLayout(layout);
		principalPanel.setBorder(BorderFactory.createLoweredBevelBorder());
		botaoPanel = new JPanel();
		botaoPanel.setLayout(layout);
		botaoPanel.setBorder(BorderFactory.createLoweredBevelBorder());
	
		//Label posição
		constraint.fill = GridBagConstraints.HORIZONTAL;
		constraint.anchor = GridBagConstraints.NORTH;
		constraint.insets = new Insets(20, 20, 0, 10);
		setComponent(cadastrarProdLabel, 0, 0, 1, 1);
	
		constraint.insets = new Insets(15, 15, 15, 0);
		setComponent(prodLabel, 0, 0, 1, 1);
		
		constraint.insets = new Insets(0, 15, 15, 0);
		setComponent(descricaoLabel, 1, 0, 1, 1);
		
		constraint.insets = new Insets(0, 15, 10, 0);
		setComponent(tamLoteLabel, 5, 0, 1, 1);
		
		//TextField posição
		constraint.insets = new Insets(15, 0, 15, 15);
		setComponent(prodTextField, 0, 1, 1, 1);
		
		constraint.insets = new Insets(0, 0, 10, 15);
		setComponent(tamLoteTextField, 5, 1, 1, 1);
		
		//TextArea posição
		constraint.ipadx = 100;
		constraint.ipady = 70;
		constraint.insets = new Insets(0, 0, 15, 15);
		setComponent(scroll, 1, 1, 2, 4);
		
		//Panel posição
		constraint.ipady = 0;
		constraint.fill = GridBagConstraints.BOTH;
		constraint.insets = new Insets(10, 20, 10, 20);
		setComponent(principalPanel, 1, 0, 3, 6);
		
		constraint.insets = new Insets(10, 20, 20, 20);
		setComponent(botaoPanel, 7, 0, 3, 1);
		
		//Button posição
		constraint.ipadx = 40;
		constraint.ipady = 7;
		constraint.fill = GridBagConstraints.NONE;
		constraint.anchor = GridBagConstraints.SOUTHEAST;
		constraint.insets = new Insets(0, 0, 10, 15);
		setComponent(salvarButton, 6, 1, 1, 1);

		constraint.anchor = GridBagConstraints.CENTER;
		constraint.insets = new Insets(10, 0, 10, 0);
		setComponent(cadRoteiroButton, 7, 1, 1, 1);
		
		//Add
		principalPanel.add(prodLabel);
		principalPanel.add(descricaoLabel);
		principalPanel.add(tamLoteLabel);
		principalPanel.add(prodTextField);
		principalPanel.add(tamLoteTextField);
		principalPanel.add(scroll);
		principalPanel.add(salvarButton);
		
		botaoPanel.add(cadRoteiroButton);
		
		container.add(cadastrarProdLabel);
		container.add(principalPanel);
		container.add(botaoPanel);
	}
	
	private void setComponent(Component component, int row, int column, int weight,
							  int height){
		constraint.gridx = column;
		constraint.gridy = row;
		constraint.weightx = weight;
		constraint.weighty = height;
		layout.setConstraints(component, constraint);
	}

	public void actionPerformed(ActionEvent ae) {
		// TODO Auto-generated method stub
		if( ae.getSource() == salvarButton )
        {
        	       	
        	setVisible(false);
        }
		
	}
	
	//public static void main(String[] args){
	//	ProdCadastro produto = new ProdCadastro();
	//}
}
