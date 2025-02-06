package Model;

public class Professor extends Pessoa {
    // atributos
    private double salario;

    // construtor
    public Professor(String nome, String cpf, double salario) {
        super(nome, cpf);
        this.salario = salario;
    }

    // getter and setter

    public double getSalario() {
        return salario;
    }

    public void setSalario(double salario) {
        this.salario = salario;
    }

    @Override
    // exibir informações
    public void exibirInformacoes() {
        super.exibirInformacoes();
        System.out.println("Salário: R$ " + salario);
    }

}
