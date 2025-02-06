package Controller;

import java.util.ArrayList;
import java.util.List;

import Model.Aluno;
import Model.Professor;

public class Curso {
    // atributo
    private String nomeCurso;
    private Professor professor;
    private List<Aluno> alunos;

    // construtor
    public Curso(String nomeCurso, Professor professor, List<Aluno> alunos) {
        this.nomeCurso = nomeCurso;
        this.professor = professor;
        this.alunos = new ArrayList<>();
    }

    // método Adicionar alunos
    public void adicionarAluno(Aluno aluno) {
        alunos.add(aluno);
    }

    // exibir informações do curso
    public void exibirInformacoesCurso() {
        System.out.println("Curso: " + nomeCurso);
        System.out.println("===================");
        System.out.println("Nome Professor : " + professor.getNome());
        System.out.println("===================");
        System.out.println("Lista de Alunos: ");
        int i = 1;
        for (Aluno aluno : alunos) {
            System.out.println(i + "  " + aluno.getNome());
            i++;
        }
        
    }
}
