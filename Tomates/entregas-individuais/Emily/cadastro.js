const usuario = document.querySelector('#usuario');
const senha = document.querySelector('#senha');
const email = document.querySelector("#email")
const form = document.querySelector('form');
const erroUsuario = document.querySelector('#erro-usuario');
const erroSenha = document.querySelector('#erro-senha');
const erroEmail = document.querySelector('#erro-email');
const msgSucesso = document.querySelector('#mensagem-sucesso');

form.addEventListener('submit', (e) => {
    erroUsuario.textContent = "";
    erroSenha.textContent = "";
    erroEmail.textContent = "";
    msgSucesso.textContent = "";

    const temMaiuscula = /[A-Z]/.test(senha.value);
    const temEspecial = /[^A-Za-z0-9]/.test(senha.value);

    let erro = false;

    if(!usuario.value){
        erroUsuario.textContent = "O nome de usuário é obrigatório."
        erro = true
    }

    if(senha.value.length < 9){
    
        erroSenha.textContent = "A senha deve ter pelo menos 9 caracteres.";
        
        erro = true
    } else if (!temMaiuscula) {
        erroSenha.textContent = "A senha deve conter uma letra maiúscula.";
        erro = true;
    } else if (!temEspecial) {
        erroSenha.textContent = "A senha deve conter um caractere especial.";
        erro = true;
    }

    // Se houver qualquer erro, impedimos o envio
    if (erro) {
        e.preventDefault();

    }else {
        // 3. Se NÃO houver erro, exibe sucesso!
        e.preventDefault(); // Impede o envio real para podermos ver a mensagem
        alert("Cadastro realizado com sucesso!");
        location.href = "login.html"
    }

})

console.log(usuario);
console.log(senha);