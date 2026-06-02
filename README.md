# NotADiary

> Um diário emocional para iOS que vai além das palavras — registre seus sentimentos com texto, fotos, música e **feedback háptico** que traduz cada emoção em sensação.

[![Disponível na App Store](https://img.shields.io/badge/App_Store-Baixar-0D96F6?logo=apple&logoColor=white)](https://apps.apple.com/br/app/notadiary/id6753695305)

📱 **[Disponível na App Store](https://apps.apple.com/br/app/notadiary/id6753695305)**

---

## Sobre

**NotADiary** ("Não é um diário") é um app de journaling focado no registro emocional. A proposta é simples: em vez de só escrever, você associa cada entrada a uma **emoção**, a uma **música** e a **fotos** — e o próprio dispositivo "responde" à emoção através de padrões de vibração (háptica) cuidadosamente desenhados para cada sentimento.

Um mascote acompanha cada entrada, mudando de humor de acordo com a emoção registrada, dando personalidade ao seu diário.

## ✨ Funcionalidades

- **📝 Entradas de diário** — título, texto, data e a emoção do momento.
- **😊 Mascote emocional** — um personagem que reflete o humor da entrada, com 12 estados de humor (alegria, raiva, surpresa, medo, amor, tristeza, e suas variantes intensas).
- **📳 Háptica emocional** — padrões de vibração exclusivos construídos com **Core Haptics** para cada emoção (ex.: "batimento cardíaco" para amor, "tremor" para medo, "explosão" para raiva).
- **🎵 Integração com Apple Music** — busque e associe uma música a cada entrada via **MusicKit**, com reprodução dentro do app e suporte a **Music Haptics**.
- **📷 Fotos** — anexe imagens às suas entradas em uma galeria visual.
- **☁️ Sincronização via iCloud** — todas as entradas e preferências são armazenadas e sincronizadas com **CloudKit**.
- **🔔 Lembretes** — agende notificações para lembrar de registrar seu dia.
- **📤 Compartilhamento de Cards** — exporte e compartilhe entradas como um arquivo `.card` (tipo de documento customizado).
- **👋 Onboarding** — fluxo de boas-vindas com cadastro de nome e configuração de notificações.

## 🛠 Tecnologias

| Área | Tecnologia |
|------|-----------|
| UI | SwiftUI |
| Persistência / Sync | CloudKit (iCloud) |
| Música | MusicKit · MediaPlayer · AVFoundation |
| Háptica | Core Haptics · MediaAccessibility (Music Haptics) |
| Notificações | UserNotifications |
| Arquitetura | MVVM |

> Há também trabalho exploratório de integração com **HealthKit (State of Mind)** para registro de humor no app Saúde.

## 📋 Requisitos

- **iOS 26.0** ou superior
- Xcode 26 ou superior
- Conta iCloud (para sincronização)
- Assinatura do Apple Music (para as funcionalidades de música)

## 📁 Estrutura do projeto

```
NotADiary/
├── NotADiaryApp.swift          # Entry point
├── Models/
│   ├── JournalModels/          # JournalEntry, Entry, Mascot, Image
│   ├── ShareModels/            # Card (Transferable / UTType)
│   ├── MusicKitModels/         # Music Haptics
│   ├── HealthKitModels/        # State of Mind (exploratório)
│   ├── EmotionHapticEngine.swift  # Padrões de vibração por emoção
│   ├── NotificationsModel.swift
│   └── PreferenceModel.swift
├── ViewModels/
│   ├── CloudKitVM/             # Sincronização de entradas e preferências
│   ├── MusicKitVM/             # Player e busca de músicas
│   ├── JournalVM/              # Lógica do mascote
│   ├── ShareVM/                # Geração e conversão de Cards
│   └── HealthKitVM/
├── Views/
│   ├── OnboardingViews/        # Fluxo de cadastro e notificações
│   ├── JournalViews/           # Lista, criação, edição e visualização de entradas
│   ├── ShareViews/             # Card compartilhável
│   └── Components/             # Componentes reutilizáveis (mascote, música, fotos…)
├── Extensions/
└── Assets/                     # Cores, mascotes (SVG) e ícones
```

A arquitetura segue o padrão **MVVM**, separando claramente modelos de dados, lógica de apresentação (ViewModels com `@Observable`/`ObservableObject`) e as Views em SwiftUI.

## 👥 Time

Projeto desenvolvido por:

- Pedro Augusto (Tessaro)
- Francisco Losada
- Enzo Ferroni
- Vinicius Alves Marques

---

<p align="center">
  <a href="https://apps.apple.com/br/app/notadiary/id6753695305">Baixe o NotADiary na App Store</a>
</p>
