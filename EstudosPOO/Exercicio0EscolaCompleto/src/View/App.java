package View;

import java.util.Scanner;

import Controller.Curso;
import Model.Professor;

public class App {
    public static void main(String[] args) throws Exception {
        Scanner sc = new Scanner(System.in);
        Professor professor = new Professor("José Pereira", "123.456.789-59", 15000.00);

    Cursos curso = new Curso("Curso POO", professor);
    int operacao;
    boolean continuar = true;
    while (continuar) {
        System.out.println("Escolha a Opção Desejada: ");
        System.out.println("1. Cadastrar Aluno");
        System.out.println("2. Informações do Curso");
        System.out.println("3. Sair");
        System.out.println("===========================");
    }
}
