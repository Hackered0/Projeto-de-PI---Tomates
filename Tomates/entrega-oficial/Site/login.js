const usuario = document.querySelector('#usuario'); 
const senha = document.querySelector('#senha');
const form = document.querySelector('form');
const erroUsuario = document.querySelector('#erro-usuario');
const erroSenha = document.querySelector('#erro-senha');

form.addEventListener('submit', (e) => {
    erroUsuario.textContent = "";
    erroSenha.textContent = "";

    const temMaiuscula = /[A-Z]/.test(senha.value);
    const temEspecial = /[^A-Za-z0-9]/.test(senha.value);

    let enviarForm = false;

    if(!usuario.value){
        erroUsuario.textContent = "O nome de usuário é obrigatório."
        enviarForm = true
    }

    if(senha.value.length < 9){
    
        erroSenha.textContent = "A senha deve ter pelo menos 9 caracteres.";
        
        enviarForm = true
    } else if (!temMaiuscula) {
        erroSenha.textContent = "A senha deve conter uma letra maiúscula.";
       enviarForm = true;
    } else if (!temEspecial) {
        erroSenha.textContent = "A senha deve conter um caractere especial.";
        enviarForm = true;
    }

    // Se houver qualquer erro, impedimos o envio
    if (enviarForm) {
        e.preventDefault();
    }

    if (!enviarForm) {
        window.location.href = "index.html";
    }
})

console.log(usuario);
console.log(senha);