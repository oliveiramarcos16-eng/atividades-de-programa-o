// 1. Herança
class Pessoa {
  constructor(public nome: string) {}
}

class Aluno extends Pessoa {
  constructor(nome: string, public matricula: string) {
    super(nome);
  }
}

class Professor extends Pessoa {
  constructor(nome: string, public disciplina: string) {
    super(nome);
  }
}

// 2. Encapsulamento
class ContaBancaria {
  protected saldo: number = 0;

  depositar(valor: number): void {
    if (valor > 0) this.saldo += valor;
  }

  sacar(valor: number): void {
    if (valor > 0 && valor <= this.saldo) this.saldo -= valor;
  }

  consultarSaldo(): number {
    return this.saldo;
  }
}

// 3. Polimorfismo
class Animal {
  emitirSom(): void {
    console.log("Som do animal");
  }
}

class Cachorro extends Animal {
  emitirSom(): void {
    console.log("Au Au!");
  }
}

class Gato extends Animal {
  emitirSom(): void {
    console.log("Miau!");
  }
}

// 4. Abstração
abstract class Forma {
  abstract calcularArea(): number;
}

class Retangulo extends Forma {
  constructor(private largura: number, private altura: number) {
    super();
  }

  calcularArea(): number {
    return this.largura * this.altura;
  }
}

class Circulo extends Forma {
  constructor(private raio: number) {
    super();
  }

  calcularArea(): number {
    return Math.PI * (this.raio ** 2);
  }
}

// 5. Projeto integrando os quatro pilares
abstract class Autenticavel {
  abstract autenticar(): boolean;
}

class UsuarioEscola extends Autenticavel {
  protected senhaHash: string = "123456";

  constructor(public nome: string, protected senha: string) {
    super();
  }

  autenticar(): boolean {
    return this.senha === this.senhaHash;
  }

  apresentar(): void {
    console.log(`Olá, meu nome é ${this.nome}.`);
  }
}

class AlunoEscola extends UsuarioEscola {
  apresentar(): void {
    console.log(`Aluno: ${this.nome}`);
  }
}

class ProfessorEscola extends UsuarioEscola {
  apresentar(): void {
    console.log(`Professor: ${this.nome}`);
  }
}
