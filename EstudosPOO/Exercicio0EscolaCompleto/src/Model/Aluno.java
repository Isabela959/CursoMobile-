package Model;

public class Aluno extends Pessoa {
    // atributos
    private String matricula;
    private double nota;

    // construtor
    public Aluno(String nome, String cpf, String matricula, double nota) {
        super(nome, cpf);
        this.matricula = matricula;
        this.nota = nota;
    }

    // getter and setter
    public String getMatricula() {
        return matricula;
    }

    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }

    public double getNota() {
        return nota;
    }

    public void setNota(double nota) {
        this.nota = nota;
    }

    @Override
    // exibir informações -- Sobrescrita (reescrevendo o método)
    public void exibirInformacoes() {
        super.exibirInformacoes();
        System.out.println("Matrícula: " + matricula);
        System.out.println("Nota: " + nota);
    }

    // avaliável
    public void avaliarDesempenho() {
        if (nota >= 6.0) {
            System.out.println("Aluno Aprovado");
        } else {
            System.out.println("Aluno Reprovado");
        }
    }
}
