const chai = require("chai");
const chaiHttp = require("chai-http");
const server = require("../src/app");
const { expect } = chai;
const setupAuthTokens = require("./authHelper");

chai.use(chaiHttp);

let userToken;

describe("User API", () => {

  before(async () => {
    const tokens = await setupAuthTokens();
    userToken = tokens.userToken;
  });

  describe("POST /users", () => {
    it("Deve criar um usuário válido", (done) => {
      chai.request(server)
        .post("/users/register")
        .send({ nome: "binha", senha: "123456" })
        .end((err, res) => {
          expect(res).to.have.status(201);
          expect(res.body).to.have.property("usuario");
          expect(res.body.usuario).to.have.property("id");
          done();
        });
    });

    it("Deve retornar erro ao criar usuário sem nome", (done) => {
      chai.request(server)
        .post("/users/register")
        .send({ senha: "123" })
        .end((err, res) => {
          expect(res).to.have.status(400);
          expect(res.body).to.have.property("error");
          done();
        });
    });
  });

  describe("GET /users/nome/:nome", () => {
    it("Deve buscar um usuário pelo nome", (done) => {
      chai.request(server)
        .get("/users/nome/testuser")
        .set("Authorization", `Bearer ${userToken}`)
        .end((err, res) => {
          expect(res).to.have.status(200);
          expect(res.body).to.have.property("id");
          expect(res.body.nome).to.equal("testuser");
          done();
        });
    });

    it("Deve retornar erro para usuário inexistente", (done) => {
      chai.request(server)
        .get("/users/nome/nao_existe")
        .set("Authorization", `Bearer ${userToken}`)
        .end((err, res) => {
          expect(res).to.have.status(404);
          expect(res.body).to.have.property("error");
          done();
        });
    });
  });
});
