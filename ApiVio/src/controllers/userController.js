const connect = require("../db/connect");
const validateUser = require("../services/validateUser")
const validadeCpf = require("../services/validateCpf")

module.exports = class userController {
  static async createUser(req, res) {
    const { cpf, email, password, name, data_nascimento } = req.body;

    const validation = validateUser(req.body)
    if(validation){
      return res.status(400).json(validation)
    }
    const cpfValidation = await validadeCpf(cpf,null)
    if(cpfValidation){
      return res.status(400).json(cpfValidation)
    }

      const query = `INSERT INTO usuario (cpf,password,email,name,data_nascimento) VALUES(
      '${cpf}',
      '${password}',
      '${email}',
      '${name}',
      '${data_nascimento}')`;

      // Executando a query criada

      try {
        connect.query(query, function (err) {
          if (err) {
            console.log(err);
            console.log(err.code);
            if (err.code === "ER_DUP_ENTRY") {
              return res
                .status(400)
                .json({ error: "O email ou CPF já está vinculado a outro usuário" });
            } // if
            else {
              return res
                .status(500)
                .json({ error: "Erro Interno do Servidor" });
            } // else
          } // if
          else {
            return res
              .status(201)
              .json({ message: "Usuário Criado com Sucesso" });
          } // else
        }); // connect
      } catch (error) {
        console.error(error);
        res.status(500).json({ error: "Erro Interno de Servidor" });
      } // catch
    } // else
   // CreateUser

  static async getAllUsers(req, res) {
  }

  static async updateUser(req, res) {
    const { id_usuario, name, email, password, cpf } = req.body;
     const validation = validateUser(req.body)
     if(validation){
      return res.status(400).json(validation)
     }
     const cpfValidation = await validadeCpf(cpf,id)
     if(cpfValidation){
      return res.status(400).json(cpfValidation)
     }
    const query = `UPDATE usuario SET name=?, email=?, password=?, cpf=? WHERE id_usuario=?`;
    const values = [name, email, password, cpf, id_usuario];

    try {
      connect.query(query, values, function (err, results) {
        if (err) {
          if (err.code === "ER_DUP_ENTRY") {
            return res
              .status(400)
              .json({ error: "Email já Cadastrado, por outro usuário" });
          } else {
            console.error(err);
            return res.status(500).json({ error: "Erro Interno do Servidor" });
          }
        }
        if (results.affectedRows === 0) {
          return res.status(404).json({ error: "Usuário não Encontrado" });
        }
        return res
          .status(200)
          .json({ message: "Usuário atualizado com Sucesso" });
      });
    } catch (error) {
      console.error("Erro ao executar consulta: ", error);
      return res.status(500).json({ error: "Erro Interno do Servidor" });
    }
  }

  static async deleteUser(req, res) {
    const usuarioId = req.params.id_usuario;
    const query = `DELETE FROM usuario WHERE id_usuario = ?`;
    const values = [usuarioId];
    try {
      connect.query(query, values, function (err, results) {
        if (err) {
          console.error(err);
          return res.status(500).json({ error: "Erro Interno do Servidor" });
        }
        if(results.affectedRows === 0){
          return res.status(404).json({error:"Usuário não Encontrado"})
        }
        return res.status(200).json({message:"Usuário Excluido com Sucesso"})
      });
    } catch (error) {
      console.error(error)
      return res.status(500).json({error: "Erro Interno do Servidor"})
    }
  }

  static async loginUser(req, res){
    const{email, password} = req.body

    if(!email||!password){
      return res.status(400).json({error:"Email e senha são obrigratorios"})
    }

    const query = `SELECT * FROM usuario WHERE email = ?`

    try {
      connect.query(query,[email],(err, results)=> {
        if(err){
          console.log(err);
          return res.status(500).json({error:"Erro interno do servidor"})
        }
        if(results.length===0){
          return res.status(401).json({error:"Usuário não encontrado"})
        }
        const user =results[0];

        if(user.password !== password){
          return res.status(403).json({error:"Senha incorreta"})
        }

        return res.status(200).json({message:"Login bem sucedido", user})

      })
    } catch (error) {
      console.log(error);
      return res.status(500).json({error:"Erro interno do servidor"})
    }
  }
};