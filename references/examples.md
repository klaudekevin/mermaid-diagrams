# Mermaid Diagram Examples

## Flowchart

```mermaid
flowchart TD
    A([Start]) --> B{Decision}
    B -- Yes --> C[Action A]
    B -- No --> D[Action B]
    C --> E([End])
    D --> E
```

## Sequence Diagram

```mermaid
sequenceDiagram
    participant U as User
    participant A as API
    participant DB as Database
    U->>A: POST /login {email, password}
    A->>DB: SELECT user WHERE email=?
    DB-->>A: user record
    A-->>U: 200 OK {token}
```

## Entity-Relationship

```mermaid
erDiagram
    USER {
        int id PK
        string email
        string name
    }
    ORDER {
        int id PK
        int user_id FK
        datetime created_at
    }
    ITEM {
        int id PK
        int order_id FK
        string sku
        int qty
    }
    USER ||--o{ ORDER : places
    ORDER ||--|{ ITEM : contains
```

## Class Diagram

```mermaid
classDiagram
    class Animal {
        +String name
        +int age
        +speak() string
    }
    class Dog {
        +fetch() void
    }
    class Cat {
        +purr() void
    }
    Animal <|-- Dog
    Animal <|-- Cat
```

## State Diagram

```mermaid
stateDiagram-v2
    [*] --> Idle
    Idle --> Processing : submit
    Processing --> Success : ok
    Processing --> Error : fail
    Success --> [*]
    Error --> Idle : retry
```

## Gantt Chart

```mermaid
gantt
    title Project Timeline
    dateFormat  YYYY-MM-DD
    section Design
    Wireframes      :a1, 2024-01-01, 7d
    UI Design       :a2, after a1, 7d
    section Dev
    Backend API     :b1, after a2, 14d
    Frontend        :b2, after a2, 14d
    section Launch
    QA Testing      :c1, after b1, 7d
    Deploy          :c2, after c1, 2d
```

## Git Graph

```mermaid
gitGraph
    commit id: "init"
    branch feature/auth
    checkout feature/auth
    commit id: "add login"
    commit id: "add logout"
    checkout main
    merge feature/auth
    commit id: "v1.0"
```

## Mindmap

```mermaid
mindmap
  root((Project))
    Frontend
      React
      Tailwind
    Backend
      Node.js
      PostgreSQL
    DevOps
      Docker
      CI/CD
```

## C4 Context

```mermaid
C4Context
    title System Context — Payment Service
    Person(user, "Customer", "Makes purchases")
    System(app, "Web App", "Frontend")
    System(pay, "Payment Service", "Handles payments")
    SystemExt(stripe, "Stripe", "Payment processor")
    Rel(user, app, "Uses")
    Rel(app, pay, "API calls")
    Rel(pay, stripe, "Charges card")
```
