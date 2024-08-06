# REST API versioning
> "APIs only need to be up-versioned when a breaking change is made."

Fonte: [RestfulAPI](https://restfulapi.net/versioning/)

## Visão Geral
Alterar o número da versão de uma API deve ser o resultado de necessidades drásticas. Adicionar endpoints ou novos parâmetros
não devem ser o motivo de alteração de numero de versão, mas é valido e útil rastrear versões para dar suporte a clientes
que estejam enfrentando problemas de API.

Apesar da indicação ser explícita quanto a necessidade do versionamento de APIs o objetivo aqui é simular a necessidade 
de mudanças sem quebrar clientes existentes, permitindo a coexistência de múltiplas versões da API.

## Estrutura da API

### Códigos de Status HTTP
- **200 OK:** A solicitação foi bem-sucedida.
- **201 Created:** Um novo recurso foi criado com sucesso.
- **404 Not Found:** O recurso solicitado não foi encontrado.
- **500 Internal Server Error:** Ocorreu um erro inesperado no servidor.

### Serialização

A serialização das respostas é gerenciada por um serviço específico. As respostas seguem o formato JSON API, garantindo que os dados estejam estruturados corretamente com os seguintes campos:

- **id:** Identificador do recurso
- **type:** Tipo do recurso
- **attributes:** Atributos do recurso , incluindo `title`, `description`, `author`, `genre`, `isbn`, `created_at`, `updated_at` e, na versão 2, `publisher`.

**Exemplo de Formato JSON API:**

```json
{
  "data": {
    "id": "1",
    "type": "ebooks",
    "attributes": {
      "title": "O Alquimista",
      "description": "Uma fábula sobre seguir seus sonhos",
      "author": "Paulo Coelho",
      "genre": "Ficção",
      "isbn": "978-0061122415",
      "publisher": "HarperOne", // Disponível na versão 2
      "created_at": "2024-07-31T12:59:10Z",
      "updated_at": "2024-07-31T12:59:10Z"
      
    }
  }
}
```

### Versão 1 (v1)
Na versão 1 da API, a entidade eBook possui os seguintes atributos:
- **title:** Título do eBook
- **description:** Descrição do eBook
- **author:** Autor do eBook
- **genre:** Gênero do eBook
- **isbn:** Código ISBN do eBook
- **created_at:** Data de criação do registro
- **updated_at:** Data de atualização do registro 

### Exemplo de Requisição e Resposta

**GET /v1/ebooks**

Resposta:
```json
{
  "data": [
    {
      "type": "ebooks",
      "id": "1",
      "attributes": {
        "title": "O Alquimista",
        "description": "Uma fábula sobre seguir seus sonhos",
        "author": "Paulo Coelho",
        "genre": "Ficção",
        "isbn": "978-0061122415",
        "created_at": "2024-07-31T12:59:10Z",
        "updated_at": "2024-07-31T12:59:10Z"
      }
    }
  ]
}
```

**POST /v1/ebooks**

Requisição:
```json
{
  "data": {
    "type": "ebooks",
    "attributes": {
      "title": "O Alquimista",
      "description": "Uma fábula sobre seguir seus sonhos",
      "author": "Paulo Coelho",
      "genre": "Ficção",
      "isbn": "978-0061122415"
    }
  }
}
```

Resposta:
```json
{
  "data": {
    "type": "ebooks",
    "id": "1",
    "attributes": {
      "title": "O Alquimista",
      "description": "Uma fábula sobre seguir seus sonhos",
      "author": "Paulo Coelho",
      "genre": "Ficção",
      "isbn": "978-0061122415",
      "created_at": "2024-07-31T12:59:10Z",
      "updated_at": "2024-07-31T12:59:10Z"
    }
  }
}
```

### Versão 2 (v2)
Para atender à necessidade de incluir o atributo `publisher` nos eBooks, foi criada a versão 2 da API. 
Os clientes da versão anterior não necessitam desse novo atributo e precisam continuar utilizando a versão antiga sem 
qualquer alteração nas respostas.

Assim, existe uma pequena diferença na versão 2 que é apenas incluir este atributo nas respostas e requisições para 
criação de novos registros:

**GET /v2/ebooks**

Resposta:
```json
{
  "data": [
    {
      "type": "ebooks",
      "id": "1",
      "attributes": {
        "title": "O Alquimista",
        "description": "Uma fábula sobre seguir seus sonhos",
        "author": "Paulo Coelho",
        "genre": "Ficção",
        "isbn": "978-0061122415",
        "publisher": "HarperOne",
        "created_at": "2024-07-31T12:59:10Z",
        "updated_at": "2024-07-31T12:59:10Z"
      }
    }
  ]
}

```

**POST /v2/ebooks**

Requisição:
```json
{
  "data": {
    "type": "ebooks",
    "attributes": {
      "title": "O Alquimista",
      "description": "Uma fábula sobre seguir seus sonhos",
      "author": "Paulo Coelho",
      "genre": "Ficção",
      "isbn": "978-0061122415",
      "publisher": "HarperOne"
    }
  }
}
```

Resposta:
```json
{
  "data": {
    "type": "ebooks",
    "id": "1",
    "attributes": {
      "title": "O Alquimista",
      "description": "Uma fábula sobre seguir seus sonhos",
      "author": "Paulo Coelho",
      "genre": "Ficção",
      "isbn": "978-0061122415",
      "publisher": "HarperOne",
      "created_at": "2024-07-31T12:59:10Z",
      "updated_at": "2024-07-31T12:59:10Z"
    }
  }
}
```