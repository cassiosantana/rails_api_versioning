# API Versionada para Produtos

## Objetivo
Demonstrar a implementação de versionamento de API em um sistema de gerenciamento de ebooks. O objetivo é gerenciar mudanças na API sem quebrar clientes existentes, permitindo a coexistência de múltiplas versões da API.

## Por Que Versionar a API?
O versionamento de API é uma estratégia essencial para gerenciar mudanças e evoluções no sistema sem interromper o funcionamento dos clientes que dependem da versão atual da API. Permite a implementação de novas funcionalidades e alterações de forma incremental, garantindo que as atualizações não quebrem a integração com clientes existentes.

## Estrutura de Diretórios
```text
app/
├── controllers/
│   ├── api/
│   │   ├── v1/
│   │   │   └── ebooks_controller.rb
│   │   ├── v2/
│   │   │   └── ebooks_controller.rb
│   │   └── v3/
│   │       └── ebooks_controller.rb
├── models/
│   └── ebook.rb
config/
└── routes.rb
```
- **`app/controllers/api/v1/ebooks_controller.rb`**: Controlador para a versão 1 da API.
- **`app/controllers/api/v2/ebooks_controller.rb`**: Controlador para a versão 2 da API, onde novos atributos podem ser adicionados.
- **`app/controllers/api/v3/ebooks_controller.rb`**: Controlador para a versão 3 da API, onde a estrutura de resposta pode ser alterada e atributos renomeados.

## Versões da API

### Versão 1 (v1)

**Descrição:**

A versão inicial da API expõe endpoints para listar, visualizar e criar ebooks com os seguintes atributos: `title`, `description`, `author`, `genre` e `isbn`.

**Potenciais Problemas:**

- **Mudanças não Disruptivas:** Se você precisar adicionar um novo atributo à resposta da API, como a editora do livro, não deve haver problemas significativos, pois a estrutura básica da resposta permanece a mesma.
- **Mudanças Disruptivas:** Se você renomear um atributo existente, como `isbn` para `isbn_10`, isso causará problemas, pois os clientes existentes ainda esperam o atributo antigo e não conseguirão processar o novo.

### Versão 2 (v2)

**Descrição:**

Na versão 2, novos atributos podem ser adicionados sem remover ou renomear os existentes. Por exemplo, se você adicionar um atributo `publisher`, os clientes da versão 1 ainda funcionarão como antes, enquanto novos clientes podem utilizar o atributo adicional.

**Problemas Resolvidos:**

- **Adicionar Novos Atributos:** O cliente que utiliza a versão 1 da API não será afetado, pois o novo atributo será opcional e não alterará o funcionamento das operações existentes.
- **Novo Endpoint:** É criada uma nova versão da API (v2) para incluir o novo atributo sem interferir na versão anterior.

### Versão 3 (v3)

**Descrição:**

Na versão 3, são introduzidas mudanças disruptivas, como renomear atributos e alterar a estrutura de resposta. Por exemplo, se o atributo `isbn` for renomeado para `isbn_10` e for adicionada a paginação à resposta da lista de ebooks, isso representa uma mudança significativa.

**Problemas Resolvidos:**

- **Renomear ou Remover Atributos:** A versão 1 e 2 continuarão a funcionar com o atributo antigo, enquanto a versão 3 utiliza o novo nome. Assim, clientes antigos não precisam ser atualizados imediatamente, mas novos clientes devem usar a nova versão.
- **Alterar Estrutura de Resposta:** Com a introdução de paginação e a alteração na estrutura da resposta, a versão 3 oferece uma estrutura de dados mais rica e adaptada às novas necessidades, enquanto mantém a versão 1 e 2 intacta para compatibilidade.