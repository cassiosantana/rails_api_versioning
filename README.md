## API REST v3

**Bem-vindo à documentação da API do seu aplicativo.** Este guia fornece uma visão detalhada sobre nossa API RESTful, com foco em exemplos claros. O objetivo é capacitar desenvolvedores a integrar essa ferramenta de forma eficaz em seus aplicativos.

**1. Introdução:**

Esta API fornece acesso a dados e comunicação para funcionalidades como listagem de ebooks podendo ser paginada, exibir e criar novos registros de ebooks.

**2. Política de Versões:**

A API segue um esquema de versão para garantir compatibilidade e evolução. Enquanto encorajamos o uso da versão mais recente, a compatibilidade com versões anteriores é mantida.

**3. Endpoints e Métodos HTTP:**

Esta seção aborda os endpoints principais da sua API e seus métodos correspondentes (verbos HTTP):

* **GET /v3/ebooks?page=2:** Recupera uma lista paginada de eBooks. A resposta inclui metadados, informações de paginação e links para a próxima ou página anterior.
* ```json 
    {
      "data": [
        {
          "id": "6",
          "type": "ebooks",
          "attributes": {
            "title": "Champagne Tentacle",
            "description": "Repudiandae nisi et ipsum ullam sequi modi ex laborum. Dignissimos minus deserunt saepe expedita itaque quia reprehenderit. Adipisci neque doloremque architecto illo quos soluta incidunt. Excepturi molestias officiis dolorem id.",
            "author": "Viola Parisian",
            "genre": "Hymn",
            "publisher": "Schowalter Group",
            "isbn13": "14182503727",
            "created_at": "2024-08-25T17:44:51.474Z",
            "updated_at": "2024-08-25T17:44:51.474Z"
          }
        },
        ...
      ],
      "meta": {
        "pagination": {
            "current_page": 2,
            "next_page": 3,
            "prev_page": 1,
            "total_pages": 3,
            "total_count": 15
        }
      },
      "links": {
        "self": {
            "href": "http://localhost:3000/v3/ebooks?page=2"
        },
        "next": {
            "href": "http://localhost:3000/v3/ebooks?page=3"
        },
        "prev": {
            "href": "http://localhost:3000/v3/ebooks?page=1"
        },
        "first": {
            "href": "http://localhost:3000/v3/ebooks?page=1"
        },
        "last": {
            "href": "http://localhost:3000/v3/ebooks?page=3"
        }
      }
    } 
    ```


* **GET /v3/ebooks/{id}:** Recupera os detalhes de um eBook específico. A resposta inclui os atributos do eBook.

   ```json
    {
      "data": {
        "id": "1",
        "type": "ebooks",
          "attributes": {
          "title": "Codename: Nuclear Pickpocket",
          "description": "Ad odio expedita alias quia quisquam inventore eligendi. Voluptatum magnam quo totam sapiente. Mollitia similique vero accusantium rerum eius.",
          "author": "Vicky Johnson",
          "genre": "Romantic comedy",
          "publisher": "Schowalter Group",
          "isbn13": "22235593149",
          "created_at": "2024-08-25T18:36:04.375Z",
          "updated_at": "2024-08-25T18:36:04.375Z"
        }
      }
    }
    ```

* **POST /v3/ebooks:** Cria um novo eBook. A requisição inclui os dados para o eBook a ser adicionado. Este endpoint exige autorização para qualquer alteração.

Requisição:
```json
    {
      "data": {
        "type": "ebooks",
        "attributes": {
          "title": "O Segredo da Lua",
          "author": "Cassio Santana",
          "genre": "Ação",
          "isbn": "978-3-16-148410-0",
          "description": "Em um futuro distante, a humanidade busca respostas nas profundezas do cosmos. A jovem astrônoma, Anya, descobre um antigo artefato que pode mudar o destino da galáxia.",
          "publisher": "World Publishing"
        }
      }
    } 
```

Resposta:
```json
    {
      "data": {
        "id": "28",
        "type": "ebooks",
        "attributes": {
          "title": "O Segredo da Lua",
          "description": "Em um futuro distante, a humanidade busca respostas nas profundezas do cosmos. A jovem astrônoma, Anya, descobre um antigo artefato que pode mudar o destino da galáxia.",
          "author": "Cassio Santana",
          "genre": "Ação",
          "isbn": "978-3-16-148410-0",
          "publisher": "World Publishing",
          "created_at": "2024-08-08T14:08:41.024Z",
          "updated_at": "2024-08-08T14:08:41.024Z"
        }
      }
    }
```

**4. Tratamento de Erros:**

A API retorna respostas em JSON contendo códigos de erro e mensagens detalhadas para cenários comuns:

**404 - Not Found**

```json
{
  "errors": [
    {
      "status": "404",
      "source": {
        "pointer": "/data/id"
        },
        "title": "Not Found",
        "detail": "The Ebook requested is not available."
    }
  ]
}
```

**422 - Unprocessable entity**

```json
{
  "errors": [
    {
      "status": "422",
      "source": {
        "pointer": "/data/attributes/title"
      },
      "title": "Invalid Attribute",
      "detail": "can't be blank"
    },
    {
      "status": "422",
      "source": {
        "pointer": "/data/attributes/title"
      },
      "title": "Invalid Attribute",
      "detail": "is too short (minimum is 5 characters)"
    },
    {
      "status": "422",
      "source": {
        "pointer": "/data/attributes/author"
      },
      "title": "Invalid Attribute",
      "detail": "can't be blank"
    }
  ]
}
```

**4. Autenticação:**

Próxima Feature: Autenticação será nossa próxima implementação.

**5. Recursos Adicionais:**

Para obter mais informações sobre a API, consulte o [Wiki do GitHub](#).