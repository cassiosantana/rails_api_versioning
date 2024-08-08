# REST API versioning
> "APIs only need to be up-versioned when a breaking change is made."

Fonte: [RestfulAPI](https://restfulapi.net/versioning/)

## Visão Geral
Alterar o número da versão de uma API deve ser o resultado de necessidades drásticas. Adicionar endpoints ou novos parâmetros
não devem ser o motivo de alteração de numero de versão, mas é valido e útil rastrear versões para dar suporte a clientes
que estejam enfrentando problemas de API.

Apesar da indicação ser explícita quanto a necessidade do versionamento de APIs o objetivo aqui é simular a necessidade 
de mudanças sem quebrar clientes existentes, permitindo a coexistência de múltiplas versões da API.

### Serialização

A serialização das respostas é gerenciada por um serviço específico. As respostas seguem o formato JSON API, garantindo que os dados estejam estruturados corretamente com os seguintes campos:

- **id:** Identificador do recurso
- **type:** Tipo do recurso
- **attributes:** Atributos do recurso , incluindo `title`, `description`, `author`, `genre`, `isbn`, `created_at`, `updated_at` e, na versão 2, `publisher`.

**Exemplo de Formato JSON API:**

```json
{
  "data": [
    {
      "type": "articles",
      "id": "1",
      "attributes": {
        "title": "JSON:API paints my bikeshed!",
        "body": "The shortest article. Ever.",
        "created": "2015-05-22T14:56:29.000Z",
        "updated": "2015-05-22T14:56:28.000Z"
      },
      "relationships": {
        "author": {
          "data": {
            "id": "42",
            "type": "people"
          }
        }
      }
    }
  ],
  "included": [
    {
      "type": "people",
      "id": "42",
      "attributes": {
        "name": "John",
        "age": 80,
        "gender": "male"
      }
    }
  ]
}

```

### Fonte

O JSON exibido acima foi retirado do [JSON:API](https://jsonapi.org/examples/#sparse-fieldsets), um padrão para APIs JSON.

### Versão 1 (v1)
Na versão 1 da API, a entidade eBook possui os seguintes atributos:
- **title:** Título do eBook
- **description:** Descrição do eBook
- **author:** Autor do eBook
- **genre:** Gênero do eBook
- **isbn:** Código ISBN do eBook
- **created_at:** Data de criação do registro
- **updated_at:** Data de atualização do registro

### Versão 2 (v2)
Para atender à necessidade de incluir o atributo `publisher` nos eBooks, foi criada a versão 2 da API. 
Os clientes da versão anterior não necessitam desse novo atributo e precisam continuar utilizando a versão antiga sem 
qualquer alteração nas respostas.

Assim, existe uma pequena diferença na versão 2 que é apenas incluir este atributo nas respostas e requisições para 
criação de novos registros:

### Exemplos de Requisições e Respostas

**GET /v2/ebooks/1**

Resposta:
```json
{
  "data": {
    "id": "1",
    "type": "ebooks",
    "attributes": {
      "title": "O Segredo da Lua",
      "description": "Em um futuro distante, a humanidade busca respostas nas profundezas do cosmos. A jovem astrônoma, Anya, descobre um antigo artefato que pode mudar o destino da galáxia.",
      "author": "Cassio Santana",
      "genre": "Ação",
      "isbn": "978-3-16-148410-0",
      "publisher": "World Publishing",
      "created_at": "2024-08-08T14:07:49.671Z",
      "updated_at": "2024-08-08T14:07:49.671Z"
    }
  }
}
```

**POST /v2/ebooks**

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

### Exemplo de erros

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