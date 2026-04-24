FK

FitKarma

Developer & UI Documentation

India's Offline-First Fitness Platform  ·  Built for Bharat

Flutter 3.x

Riverpod 2.x

Drift/SQLCipher

Appwrite

35+ Modules

45+ Screens

FitKarma is India's most affordable, privacy-first, offline-capable fitness and
health platform. Built with Flutter 3.x, Riverpod 2.x, Drift (SQLCipher), and
Appwrite — designed for every Indian, from Rs.6,000 phones to flagships.

*  Offline-first architecture with Drift local DB + Appwrite cloud sync

*  AES-256-GCM encryption with HKDF per data class for medical privacy

*  45+ screens: glassmorphism, bento-grid, spring physics animations

*  India-specific: ABHA, Lab OCR, Ayurveda, 22 regional languages

*  35+ modules: Nutrition AI, Wearables, Mental Health, Period Tracker, and more

*  Karma gamification: XP, streaks, challenges, leaderboards

*  < 50 MB APK  *  < 2s cold start  *  < 1s dashboard render

Food Log
nn nn nnnn

1,840

kcal  /  2200 goal

Carbs

Protein

Fat

FitKarma
Namaste, Rahul n

Breakfast  n
R
Poha, Tea

1,247

Karma Points  (cid:127)  Level 8

Today's Activity

Lunch  nn
Dal Rice, Raita

Snack  nn
Fruits, Chai

412 kcal

+
680 kcal

220 kcal

82%

Steps

61%

Active

45%

Cal

7,842
n
n
Steps  / 10K goal
78% complete
Food

Home

1.8L
n
Water  / 2.5L

n

Workout

72% of goal
Health

n

Profile

n Insight

You sleep better after yoga days.

Pattern over 14 days detected.

Version

2.0.0

Pages

150+

Updated

2025

Stack

Flutter+Riverpod+Drift+Appwrite

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

150 pages · 24 chapters

§ TOC
Table of Contents

§ 1    Project Overview

Architecture, Principles, Tech Stack

§ 2    UI Design Reference

Colour Tokens, Glassmorphism, Typography

§ 3    Application Architecture

Layer Diagram, Component Map

§ 4    Folder Structure

Complete Module Tree

§ 5    Appwrite Setup

Collections, Indexes, Functions

§ 6    Database Schema

All 25+ Collections with Attributes

§ 7    Local Storage — Drift

Tables, DAOs, Encryption

§ 8    Offline Sync Architecture

Idempotency, Dead-Letter Queue, Vectors

§ 9    Authentication & Onboarding

Phone OTP, Google, ABHA, Biometrics

§ 10    Core Feature Modules

Nutrition, Workout, Steps, Sleep, Water

§ 11    Advanced Features

AI Scanner, Ayurveda, Recipe Engine

§ 12    Health Monitoring

BP, Glucose, SpO2, ECG, Lab OCR

§ 13    Lifestyle & Wellness

Meditation, Journal, Stress, Period

§ 14    Social & Community

Feed, Challenges, Leaderboards

§ 15    Platform & Infrastructure

Notifications, Widgets, WhatsApp Bot

§ 16    Security & Privacy

Encryption, Biometrics, GDPR

§ 17    External API Integrations
Fitbit, Razorpay, ABHA, Zomato

§ 18    Performance Contracts
SLAs, Benchmarks, Battery

§ 19    State Management

Riverpod Patterns, Providers

§ 20    Monetization & Subscriptions
Razorpay, Plans, Karma Economy

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 2

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 21    Testing Strategy

Unit, Widget, Integration, Golden

§ 22    Coding Standards

Dart Conventions, Architecture Rules

§ 23    Environment Configuration
Secrets, .env, RemoteConfig

§ 24    CI/CD Pipeline

GitHub Actions, Backup, Admin Dashboard

§ UI    App Demo — Screen Gallery

45+ Annotated UI Mockups

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 3

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

India's Fitness Platform

§ 1
Project Overview

1.1 App Identity

Property

App Name

Tagline

Bundle ID

Architecture

Tech Stack

Target Market

Languages

Value

FitKarma

India's Most Affordable, Culturally-Rich Fitness App

com.fitkarma.app

Offline-first, server-synced via Appwrite

Flutter 3.x · Riverpod 2.x · Drift (SQLite) · Appwrite

Indian users across all connectivity tiers (2G–5G)

English + 22 Indian regional languages

App Size Target

< 50 MB (enforced in CI/CD)

Dashboard Load

< 1 second

Feature Modules

Screens

35+

45+

1.2 Design Principles

n Offline-first

All writes go to Drift instantly; Appwrite is only touched during sync. Zero loading states for core actions.

n Zero recurring API costs

Critical data paths never depend on external APIs at runtime.

n Privacy-first

AES-256-GCM encrypted medical and reproductive health data with HKDF per data class. No advertising SDKs.

No data sold to third parties.

n Culturally rich

Indian  food  database,  Ayurveda  engine,  ABHA  integration,  festival  calendar,  and  regional  language  support

baked in.

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 4

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

n Performance

Sub-50  MB  install  size,  <2s  cold  start,  <1s  dashboard  render,  <3%  battery  drain  per  hour  during  background

tracking.

n Single backend

Appwrite replaces all Firebase dependencies. No Firebase SDK except firebase_messaging for push tokens.

n Comprehensive health coverage

Blood  pressure,  glucose,  lab  report  OCR,  mental  health,  wearable  sync,  meal  planning,  and  chronic  disease

management modules.

n Accessible

Screen reader, font scaling, full dark mode, and high-contrast mode support built in.

n India-ecosystem integrated

ABHA health ID linking, UPI deep-links, WhatsApp bot logging, Zomato/Swiggy restaurant calories, lab report

OCR.

1.3 Device Tier System
FitKarma runs on devices from n6,000 budget phones to flagship handsets. The UI degrades gracefully across
three tiers:

Tier

Low

Mid

High

RAM

Glassmorphism

Animations

< 3 GB

Disabled

Simplified fades

3–6 GB

Enabled (reduced)

Spring physics

> 6 GB

Full + glow

All effects

Blur

Disabled

12px cap

Full

1.4 Technology Stack

Layer

UI

State

Technology

Flutter 3.x

Riverpod 2.x

Purpose

Cross-platform rendering with 45+ screens

Reactive DI, async state, code-gen providers

Local DB

Drift (SQLCipher)

Type-safe SQLite with AES-256 encryption

Backend

Appwrite

Auth, Database, Storage, Functions, Realtime

Payments

Razorpay

Subscription billing, UPI, cards, wallets

Push

Firebase Messaging

FCM token only — no other Firebase SDK

Analytics

Sentry

Crash reporting and performance monitoring

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 5

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Layer

Technology

Purpose

Animation

Lottie + Rive

Streak fire, confetti, logo reveal, level-up

Fonts

Plus  Jakarta  Sans  +  JetBrains

Mono

Variable weight UI + metric monospace

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 6

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Design System & Visual Language

§ 2
UI Design Reference

2.1 Design Philosophy

Pillar

Engineering Implication

Spatial Depth

Fluid Motion

Bold Information

Three-layer surface model (bg ﬁ cards ﬁ foreground). BackdropFilter blur on
all Plane 2 cards — tier-gated.

Spring  physics  via  SpringDescription  on  all  transitions.  Zero  linear  tweens.

Tier-gated: low-end uses simplified fades.

Metric  numbers  render  at  56–72sp  with  JetBrains  Mono  variable  font.  One

dominant metric per screen.

Visual Restraint

Not every surface blurs. Not every card glows. Glow is a reward, not a default.

Dark-First

Dark  mode  is  the  primary  design  target.  Light  mode  is  a  deliberate  warm

inversion.

Cultural Pulse

Bilingual labels, Indian units, festival context, and ABHA integration are core.

2.2 Dark Mode Colour Tokens

Dark mode is the design baseline. All implementations start here.

Token

Hex

Usage

bg0

bg1

bg2

surface0

surface1

surface2

primary

accent

#080810

Deepest base layer — shows at screen edges

#0F0F1A

Primary scaffold background

#161625

Secondary/nested screen background

#1C1C2E

Base card surface

#22223A

Elevated cards, bottom sheets

#2A2A45

Tooltips, pop-overs

#FF6B35

CTAs, FAB, active nav, ring fill — vibrant orange

#FFB547

Karma XP, streaks, insight card highlights

secondary

#7B6FF0

Hero accents, level badges, progress fills

teal

#00D4B4

Water, SpO2, Ayurveda, Medication

success

#4ADE80

Steps rings, habits, healthy readings

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 7

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Token

warning

error

rose

purple

Hex

Usage

#FBBF24

Elevated readings, moderate risk

#F87171

Crisis readings, destructive actions

#FB7185

Period cycle, menstrual accent

#C084FC

Active minutes ring

textPrimary

#F1F0FF

Headings, primary body

textSecondary

#9B99CC

Labels, subtitles, captions

textMuted

#6B68A0

Placeholders, inactive states — decorative only

bg0
#080810

bg1
#0F0F1A

surface0
#1C1C2E

surface1
#22223A

primary
#FF6B35

accent
#FFB547

secondary
#7B6FF0

teal
#00D4B4

Figure 2.1 — Dark Mode Brand Colour Palette

success
#4ADE80

warning
#FBBF24

error
#F87171

rose
#FB7185

2.3 Light Mode Colour Tokens

Token

Hex

Notes

bg0

bg1

#F7F0E8

Warm parchment — deepest background

#FDF6EC

Primary scaffold background

surface0

#FFFFFF

Card surface

primary

#F4511E

Slightly deeper orange — better contrast on light

primaryMuted

#FEE8E2

Chip selected background

accent

#F59E0B

Karma coins

secondary

#5B50D4

Hero sections, level badges

teal

#0D9488

Water, Ayurveda

success

#22C55E

Healthy readings

textPrimary

#1A1830

All body copy

textSecondary

#6B6A96

Subtitles, labels

bg0
#F7F0E8

bg1
#FDF6EC

surface0
#FFFFFF

primary
#F4511E

accent
#F59E0B

secondary
#5B50D4

teal
#0D9488

Figure 2.2 — Light Mode Colour Palette

success
#22C55E

textPrimary
#1A1830

textSecondary
#6B6A96

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 8

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

2.4 Glassmorphism Recipe

Applied to all card widgets (Plane 2 surfaces) in dark mode on Tier: mid/high devices:

/* Flutter equivalent: ClipRRect + BackdropFilter + Container */
/* Dark Mode Glass */
background: rgba(255, 255, 255, 0.05);
border: 1px solid rgba(255, 255, 255, 0.10);
backdrop-filter: blur(12px) saturate(180%);
border-radius: 20px;

/* Light Mode Glass */
background: rgba(255, 252, 248, 0.80);
border: 1px solid rgba(244, 81, 30, 0.12);
backdrop-filter: blur(12px);   /* CAPPED at 12px — never 20px in light mode */

2.5 Typography System

Style

Font

Size

Weight

Usage

displayLg

Plus Jakarta Sans

56–72sp

ExtraBold 800

displayMd

JetBrains Mono

40–48sp

Bold

Hero  metrics,  Karma

score

Step

count,

calorie

total

h1

h2

h3

h4

body1

body2

caption

hindi

Plus Jakarta Sans

Plus Jakarta Sans

Plus Jakarta Sans

Plus Jakarta Sans

Plus Jakarta Sans

Plus Jakarta Sans

Plus Jakarta Sans

Plus Jakarta Sans

monoLg

JetBrains Mono

monoSm

JetBrains Mono

2.6 Hero Gradients

28sp

22sp

17sp

14sp

15sp

13sp

12sp

11sp

24sp

12sp

Bold 700

Screen titles

SemiBold 600

Section headings

SemiBold 600

Sub-sections

Medium 500

Card titles

Regular 400

Primary body text

Regular 400

Secondary body

Regular 400

Labels, timestamps

Regular 400

Hindi sub-labels

Bold

Metrics, vitals

Regular

Code, data

Name

Direction

Dark Mode

Used on

heroDeep

135°

#0A0818 ﬁ #1E1850

Dashboard, Karma, Profile

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 9

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Name

Direction

Dark Mode

Used on

heroSleep

180° (3-stop)

#04020F ﬁ #0D0B2E ﬁ #1C1A48

Sleep screen

heroFestival

heroWedding

heroPrimary

120°

135°

135°

#1A0A00 ﬁ #3D1500

#1A1000 ﬁ #3A2800

#1A0800 ﬁ #3D1100

Festival screens

Wedding planner

Workout, Steps

2.7 Bento Grid System

The  bento  grid  is  the  primary  layout  pattern  for  dashboard-style  screens.  Cards  of  varied  sizes  create  visual

rhythm.

// Grid definitions
nnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
n  Hero Card      n  Square  n   Row 1: 2/3 + 1/3
n  (2/3 width)    n  (1/3)   n
nnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
n  Small n  Small n  Small   n   Row 2: thirds
n  (1/3) n  (1/3) n  (1/3)   n
nnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
n  Wide (2/3)     n  Tall    n   Row 3: mixed
nnnnnnnnnnnnnnnnnnnnnnnnnnnnnn

// Gutter: 12px uniform  |  Radius: 20px standard  |  Corner XL: 28px  (hero)

2.8 Animation System

Context

Spec

Notes

Page transitions

Spring:

stiffness=100,

damping=14

Horizontal slide + scale 0.96ﬁ1.0

Bottom sheet entrance

Spring:

stiffness=260,

damping=24

Slide from bottom with bounce

FAB tap

Scale 0.92ﬁ1.0, 120ms

Haptic feedback on confirm

Ring fill (steps/activity)

Staggered 600ms, delay 200ms

CountUp on entry

XP float on log

Level-up

Streak fire

amber  +X  XP

floats  48px,

500ms

coin_burst Lottie, fade out

Full-screen

indigo  overlay  +

confetti

Spring entrance displayLg

Lottie: streak_fire, size scales

Orange banner, size (cid:181) count

Card hover/tap

Scale 0.97, duration 180ms

All tappable cards

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 10

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Context

Spec

Notes

Reduced motion

Cross-fade fallback

AccessibilityFeatures.disableAnimations

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 11

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 3
Application Architecture

Layers · Components · Data Flow

3.1 System Architecture Overview

FitKarma — System Architecture

Flutter UI

45+ Screens

Widgets

Shared 28+

Animations

Rive/Lottie

Themes

Dark/Light

Nav

GoRouter

UI Layer

Riverpod

Providers

NotifyProv

Async Notif

StateNotif

Stream/Future

RemoteConf

Feature Flags

DI

Ref.watch

State Layer

Drift/SQLCipher

Local DB+Enc

SyncEngine

Idempotent

DLQ

HKDF

Dead Letter Q

Per-Class Enc

Cache

Tile/Media

Appwrite

Auth+DB+Stor

Functions

Serverless

Realtime

Subscriptions

Razorpay

Payments

FCM

Push Only

Data Layer

Backend

UI/Flutter

Riverpod State

Data/Drift

Backend

Figure 3.1 — FitKarma Four-Layer Architecture

3.2 Architecture Layers

Layer

Technology

Responsibility

UI / Presentation

Flutter 3.x Widgets

State Management

Riverpod 2.x Providers

Rendering

screens,

handling

gestures,

navigation

Business

logic,  async  state,  dependency

injection

Data / Repository

Drift DAO + Appwrite SDK

Local reads/writes, cloud sync, cache

Backend

Appwrite (self-hosted / cloud)

Auth, DB, File storage, Functions, Realtime

Security

SQLCipher

+  HKDF

+

Biometrics

Encryption at rest, auth, key derivation

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 12

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

3.3 Offline-First Data Flow

User Action ﬁ Drift (instant write) ﬁ UI Update (optimistic)
                    ﬂ
            SyncEngine (background)
                    ﬂ  idempotency key + version vector
            Appwrite API
                    ﬂ
            Conflict Resolution ﬁ merge / last-write-wins / user-prompt
                    ﬂ
            Drift update (if server wins)

3.4 Key Architectural Decisions

n Single Backend — Appwrite

Replaces Firebase Auth, Firestore, Storage, Functions, and Realtime in a single SDK. Reduces complexity and

vendor lock-in.

n Drift (SQLCipher) over Hive/Isar

Type-safe  SQL  with  full  query  power,  foreign  keys,  transactions.  SQLCipher  adds  AES-256  encryption

transparently.

n Riverpod over BLoC

Less  boilerplate  than  BLoC/Cubit.  Auto-dispose  scoping,  family  providers,  and  code-gen  fit  Flutter  3.x

ergonomics.

n HKDF per data class
Master key ﬁ derive per-class keys for medical, reproductive, journal data. Compromise of one class does not
expose others.

n Idempotency keys on all writes

UUID v4 per mutation. Retried ops never duplicate server-side records. Dead-Letter Queue handles persistent

failures.

n Offline map tiles

Bundled tile cache for India. Workout route maps work without connectivity.

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 13

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Complete Module Tree

§ 4
Folder Structure

4.1 Root Structure

fitkarma/
nnn lib/
n   nnn core/                      # Shared infrastructure
n   n   nnn config/                # device_tier.dart, remote_config.dart
n   n   nnn constants/             # app_constants.dart, api_endpoints.dart
n   n   nnn extensions/            # dart_extensions.dart
n   n   nnn router/                # app_router.dart (GoRouter)
n   n   nnn services/              # sync_engine.dart, encryption_service.dart
n   n   nnn utils/                 # date_utils.dart, validators.dart
n   nnn features/                  # Feature modules (35+)
n   n   nnn auth/                  # Authentication & Onboarding
n   n   nnn dashboard/             # Main dashboard + Karma engine
n   n   nnn nutrition/             # Food logging, AI scanner, recipes
n   n   nnn workout/               # Workout plans, video, custom
n   n   nnn steps/                 # Pedometer, routes, challenges
n   n   nnn sleep/                 # Sleep tracking, analysis
n   n   nnn water/                 # Hydration tracking
n   n   nnn health/                # BP, glucose, SpO2, ECG
n   n   nnn lab_reports/           # OCR, ABHA, doctor share
n   n   nnn mental_health/         # Mood, journal, PHQ-9, GAD-7
n   n   nnn ayurveda/              # Dosha, herbs, remedies
n   n   nnn medication/            # Reminders, adherence
n   n   nnn wearables/             # Fitbit, Garmin, Apple Health
n   n   nnn period_tracker/        # Cycle, symptoms, predictions
n   n   nnn pregnancy/             # Week tracking, nutrition
n   n   nnn social/                # Feed, challenges, leaderboard
n   n   nnn family/                # Members, emergency contacts
n   n   nnn festival/              # Calendar, fasting, events
n   n   nnn wedding/               # Planner, diet, workout
n   n   nnn settings/              # Profile, preferences, privacy
n   n   nnn subscription/          # Razorpay, plans, karma economy
n   n   nnn widgets_home/          # Android/iOS home screen widgets
n   nnn data/
n   n   nnn local/                 # Drift database, DAOs, tables
n   n   nnn remote/                # Appwrite repositories
n   n   nnn models/                # Shared data models
n   nnn main.dart
nnn assets/
n   nnn fonts/                     # Plus Jakarta Sans, JetBrains Mono
n   nnn animations/                # Lottie JSON files
n   nnn rive/                      # Rive animation files
n   nnn food_db/                   # Bundled Indian food database JSON
n   nnn map_tiles/                 # Offline India map tiles
nnn test/                          # Unit, widget, integration tests
nnn .github/workflows/             # CI/CD pipelines

4.2 Feature Module Structure

Every feature module follows a consistent internal structure:

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 14

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

features/nutrition/
nnn data/
n   nnn nutrition_repository.dart      # Interface
n   nnn nutrition_local_source.dart    # Drift DAO wrapper
n   nnn nutrition_remote_source.dart   # Appwrite collection wrapper
nnn domain/
n   nnn models/
n   n   nnn food_item.dart
n   n   nnn meal_log.dart
n   n   nnn nutrition_goals.dart
n   nnn nutrition_service.dart         # Business logic
nnn presentation/
n   nnn providers/
n   n   nnn food_log_provider.dart
n   n   nnn nutrition_goals_provider.dart
n   nnn screens/
n   n   nnn food_log_screen.dart
n   n   nnn food_search_screen.dart
n   n   nnn meal_plan_screen.dart
n   nnn widgets/
n       nnn macro_ring_widget.dart
n       nnn food_card_widget.dart
n       nnn meal_section_widget.dart
nnn nutrition_module.dart               # Module entry point

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 15

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 5
Appwrite Setup

Collections · Indexes · Functions

5.1 Appwrite Project Configuration

// .env.prod
APPWRITE_ENDPOINT=https://cloud.appwrite.io/v1
APPWRITE_PROJECT_ID=fitkarma_prod
APPWRITE_DATABASE_ID=fitkarma_db
APPWRITE_STORAGE_BUCKET_ID=fitkarma_media

// Appwrite SDK Init (lib/core/config/appwrite_config.dart)
final client = Client()
  ..setEndpoint(AppConfig.endpoint)
  ..setProject(AppConfig.projectId)
  ..setSelfSigned(status: false);

final account   = Account(client);
final databases = Databases(client);
final storage   = Storage(client);
final functions = Functions(client);
final realtime  = Realtime(client);

5.2 Authentication Methods

Method

Provider

Notes

Phone OTP

Appwrite SMS

Primary auth — Indian mobile numbers

Google OAuth

Google

Secondary option for urban users

Email/Password

Appwrite

Fallback, required for web admin

Apple Sign-In

Apple

iOS mandatory for OAuth apps

Biometric

Local only

Locks sensitive screens post-login (flutter_biometrics)

ABHA Linking

NHA API

Links Ayushman Bharat Health Account post-login

5.3 Appwrite Functions

Function

Trigger

Purpose

calculateKarma

DB event: log create

Recalculate XP on new log entry

syncInsights

CRON: daily 04:00 IST

Generate AI insight rules from aggregated data

sendStreakNotif

CRON: 20:00 IST

Push notification for streak at risk

processLabOcr

HTTP POST

Server-side OCR fallback for complex reports

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 16

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Function

Trigger

Purpose

generateReport

HTTP GET

PDF health report for doctor sharing

razorpayWebhook

HTTP POST

Handle Razorpay subscription events

whatsappBot

HTTP POST

Parse  WhatsApp  messages

for

food/water

logging

abhaTokenRefresh

CRON: every 2h

Refresh ABHA OAuth tokens

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 17

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 6
Database Schema

6.1 Core Collections

All  collections  live  in  the  Appwrite  database.  Each  document  maps  to  an  Appwrite  collection.  Primary  key  is

always $id (Appwrite auto-generated UUID).

All Collections & Attributes

Collection: users

Attribute

user_id

name

phone

dob

gender

height_cm

weight_kg

activity_level

goal

abha_id

subscription_tier

karma_points

level

streak_days

language

created_at

Type

string

string

string

Notes

Appwrite account $id

Display name

E.164 format — primary identifier

datetime

Date of birth

enum

male/female/other/prefer_not

float

float

enum

enum

string?

enum

integer

integer

integer

string

Height in centimetres

Current weight

sedentary/light/moderate/active/very_active

lose/maintain/gain/muscle

14-digit ABHA number, nullable

free/pro/lifetime

Total accumulated XP

Derived from karma_points

Current consecutive active days

BCP-47 language code

datetime

Account creation timestamp

Collection: food_logs

Attribute

user_id

Type

string

Notes

FK ﬁ users

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 18

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Attribute

food_item_id

meal_type

quantity_g

logged_at

calories_kcal

protein_g

carbs_g

fat_g

fibre_g

Type

string

enum

float

Notes

FK ﬁ food_items

breakfast/lunch/dinner/snack

Grams consumed

datetime

Meal timestamp

Calculated from quantity

float

float

float

float

float

is_synced

boolean

Drift sync flag

Collection: workout_sessions

Attribute

user_id

plan_id

started_at

ended_at

Type

string

string?

Notes

FK ﬁ users

FK ﬁ workout_plans (nullable if custom)

datetime

Session start

datetime?

Session end

duration_min

integer

Total duration

calories_burned

exercises

notes

float

string

Estimated from MET + weight

JSON array of exercise logs

string?

Optional session notes

Collection: step_logs

Attribute

user_id

date

steps

Type

string

string

Notes

FK ﬁ users

YYYY-MM-DD

integer

Total steps for day

distance_km

float

GPS or stride estimate

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 19

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Attribute

calories

Type

float

Notes

Steps-based estimate

active_minutes

integer

Minutes above threshold

source

enum

phone/fitbit/garmin/apple_health

Collection: sleep_logs

Attribute

user_id

date

sleep_start

sleep_end

duration_min

deep_min

rem_min

light_min

awake_min

score

source

Type

string

string

datetime

datetime

integer

integer

integer

integer

integer

integer

enum

Notes

FK ﬁ users

YYYY-MM-DD night of

Total sleep time

Deep sleep minutes

REM minutes

Light sleep minutes

0–100 quality score

phone/wearable/manual

6.2 Health Collections

Collection: bp_logs

Attribute

systolic

diastolic

pulse

arm

posture

notes

Type

integer

integer

integer

enum

enum

string?

Description

mmHg

mmHg

bpm

left/right

sitting/standing/lying

Collection: glucose_logs

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 20

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Attribute

value_mg_dl

measure_type

hba1c_pct

notes

Collection: spo2_logs

Attribute

spo2_pct

pulse

notes

Collection: mood_logs

Attribute

score

emotions

journal_text_enc

iv

Collection: period_logs

Type

float

enum

float?

string?

Type

float

integer

string?

Type

integer

string

string

string

Description

Fasting or post-meal

fasting/post_meal/random/hba1c

Only for HbA1c type

Description

Oxygen saturation %

bpm

Description

1–5 scale

JSON array of emotion tags

AES-256-GCM encrypted journal entry

HKDF-derived IV

Attribute

cycle_start

cycle_end

flow

symptoms

notes_enc

Type

Description

datetime

Start of period

datetime?

End of period

enum

string

string

light/medium/heavy/spotting

JSON array

Encrypted

Collection: medication_logs

Attribute

medication_id

Type

string

Description

FK ﬁ medications

taken_at

datetime

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 21

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Attribute

skipped

notes

Type

Description

boolean

string?

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 22

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 7
Local Storage — Drift (SQLite)

Tables · DAOs · Encryption

7.1 Drift Database Setup

// lib/data/local/app_database.dart
@DriftDatabase(tables: [
  FoodLogTable, WorkoutTable, StepLogTable, SleepLogTable,
  WaterLogTable, BpLogTable, GlucoseLogTable, SpO2LogTable,
  MoodLogTable, PeriodLogTable, MedicationLogTable,
  SyncQueueTable, DeadLetterQueueTable,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override int get schemaVersion => 7;

  @override MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      // Run schema migrations
    },
  );
}

// SQLCipher setup — encrypted database
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'fitkarma.db'));
    final key = await EncryptionService.getDatabaseKey();  // HKDF-derived
    return NativeDatabase.createInBackground(file,
      logStatements: kDebugMode,
      setup: (rawDb) {
        rawDb.execute("PRAGMA key = '$key'");          // SQLCipher unlock
        rawDb.execute("PRAGMA cipher_page_size = 4096");
        rawDb.execute("PRAGMA kdf_iter = 64000");
      },
    );
  });
}

7.2 Key Tables

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 23

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

// lib/data/local/tables/food_log_table.dart
class FoodLogTable extends Table {
  IntColumn get id      => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get foodId => text()();
  RealColumn get qty    => real()();
  TextColumn get meal   => text()();  // breakfast/lunch/dinner/snack
  DateTimeColumn get loggedAt => dateTime()();
  RealColumn get kcal   => real()();
  RealColumn get protein => real()();
  RealColumn get carbs  => real()();
  RealColumn get fat    => real()();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();
  TextColumn get syncId => text().nullable()();  // idempotency key
}

// lib/data/local/tables/sync_queue_table.dart
class SyncQueueTable extends Table {
  TextColumn get id          => text().withLength(min:36, max:36)();  // UUID v4
  TextColumn get operation   => text()();  // create / update / delete
  TextColumn get collection  => text()();  // Appwrite collection name
  TextColumn get documentId  => text()();
  TextColumn get payload     => text()();  // JSON
  IntColumn  get retryCount  => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get nextRetry => dateTime()();
}

7.3 DAO Pattern

// lib/data/local/daos/food_log_dao.dart
@DriftAccessor(tables: [FoodLogTable])
class FoodLogDao extends DatabaseAccessor<AppDatabase>
    with _$FoodLogDaoMixin {
  FoodLogDao(AppDatabase db) : super(db);

  // Reactive stream — UI auto-updates on any write
  Stream<List<FoodLogEntry>> watchTodayLogs(String userId) {
    final today = DateTime.now();
    return (select(foodLogTable)
      ..where((t) => t.userId.equals(userId) &
                     t.loggedAt.isBetweenValues(
                       DateTime(today.year, today.month, today.day),
                       DateTime(today.year, today.month, today.day, 23, 59),
                     ))
      ..orderBy([(t) => OrderingTerm.asc(t.loggedAt)]))
      .watch();
  }

  Future<int> insertLog(FoodLogTableCompanion log) =>
      into(foodLogTable).insert(log);

  Future<bool> updateLog(FoodLogTableCompanion log) =>
      update(foodLogTable).replace(log);

  Future<int> deleteLog(int id) =>
      (delete(foodLogTable)..where((t) => t.id.equals(id))).go();
}

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 24

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 8
Offline Sync Architecture

Idempotency · DLQ · Version Vectors

8.1 Sync Engine Overview

Every  write  operation  in  FitKarma  is  first  committed  to  Drift  (local),  then  queued  for  Appwrite  sync.  The  sync

engine runs as a background isolate and processes the queue when connectivity is available.

// lib/core/services/sync_engine.dart — high level
class SyncEngine {
  final AppDatabase _db;
  final Databases _appwrite;
  final ConnectivityService _connectivity;

  Future<void> processQueue() async {
    if (!await _connectivity.isOnline) return;

    final pending = await _db.syncQueueDao.getPendingItems(limit: 50);
    for (final item in pending) {
      try {
        await _executeSync(item);
        await _db.syncQueueDao.markSynced(item.id);
      } on AppwriteException catch (e) {
        if (e.code == 409) {
          // Conflict — resolve and retry
          await _resolveConflict(item);
        } else if (item.retryCount >= 5) {
          // Move to Dead Letter Queue
          await _db.dlqDao.insert(item.toDeadLetter(error: e.message));
          await _db.syncQueueDao.delete(item.id);
        } else {
          await _db.syncQueueDao.incrementRetry(item.id,
            nextRetry: DateTime.now().add(Duration(minutes: pow(2, item.retryCount).toInt())));
        }
      }
    }
  }
}

8.2 Idempotency Keys

Every  mutation  includes  a  UUID  v4  idempotency  key.  If  the  same  operation  is  retried  after  a  network  failure,

Appwrite rejects the duplicate without creating a new document.

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 25

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

// Idempotency key flow
final syncId = Uuid().v4();  // generated once per user action

// Written to Drift immediately
await db.foodLogDao.insertLog(log.copyWith(syncId: syncId));

// Queue entry includes the same key
await db.syncQueueDao.enqueue(SyncItem(
  id: syncId,              // ‹ same key used as Appwrite document ID
  operation: 'create',
  collection: 'food_logs',
  payload: jsonEncode(log.toJson()),
));

8.3 Version Vectors (Per-Field)

// Each synced document carries a version vector
// { "weight_kg": 12, "goal": 7, "height_cm": 3 }
// Field-level merge: take higher version per field
// Avoids full-document last-write-wins data loss

class VersionVector {
  final Map<String, int> _vector;

  VersionVector merge(VersionVector remote) {
    final merged = Map<String, int>.from(_vector);
    remote._vector.forEach((field, remoteVer) {
      merged[field] = max(merged[field] ?? 0, remoteVer);
    });
    return VersionVector(merged);
  }
}

8.4 Dead Letter Queue

Items  that  fail  after  5  retries  are  moved  to  the  Dead  Letter  Queue  (DLQ).  Users  see  a  non-blocking  amber
banner when DLQ contains items. They can review and retry or discard them from Settings ﬁ Data & Sync.

// Dead Letter Queue table
class DeadLetterQueueTable extends Table {
  TextColumn get id          => text()();   // original sync ID
  TextColumn get collection  => text()();
  TextColumn get payload     => text()();
  TextColumn get errorMsg    => text()();
  DateTimeColumn get failedAt => dateTime()();
}

// Warning banner trigger (in DashboardScreen)
ref.watch(dlqCountProvider).when(
  data: (count) => count > 0
    ? DlqWarningBanner(count: count)   // amber glass banner
    : const SizedBox.shrink(),
  ...
);

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 26

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 9
Authentication & Onboarding

Phone OTP · Google · ABHA · Biometrics

9.1 Authentication Flow

// Primary flow: Phone OTP
1. User enters +91 phone number
2. Appwrite sends SMS OTP (6 digits, 5 min TTL)
3. User enters OTP ﬁ Appwrite session created
4. Check if user document exists in 'users' collection
5a. New user ﬁ Navigate to Onboarding flow (5 screens)
5b. Existing user ﬁ Navigate to Dashboard

// Onboarding screens (new users only)
Screen 1: Name + Gender
Screen 2: Date of birth + Height/Weight
Screen 3: Activity level + Health goals
Screen 4: Language preference (22 options)
Screen 5: ABHA linking (optional, skippable)
         ﬁ If linked: fetch health records consent
         ﬁ Biometric lock setup (optional)

9.2 Biometric Lock

Sensitive  screens  (journal  entries,  period  tracker,  blood  pressure  logs)  require  biometric  re-authentication  if

biometricLock is enabled in user preferences.

// Biometric check on sensitive screen navigation
class BiometricGuard extends ConsumerWidget {
  const BiometricGuard({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(biometricLockEnabledProvider).when(
      data: (enabled) => enabled
        ? FutureBuilder(
            future: LocalAuthentication().authenticate(
              localizedReason: 'Unlock health data',
              options: const AuthenticationOptions(biometricOnly: false),
            ),
            builder: (ctx, snap) =>
              snap.data == true ? child : const LockScreen(),
          )
        : child,
      ...
    );
  }
}

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 27

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Nutrition · Workout · Steps · Sleep · Water

§ 10
Core Feature Modules

10.1 Nutrition Module

Food  logging  with  5M+  item  Indian  food  database,  AI  camera  scanner,  meal  planning,  macro  tracking,  and

Ayurveda nutrition insights.

Feature

Search

AI Scanner

Quick Log

Meal Plan

Description

5M+ Indian food DB (bundled JSON + Appwrite search)

On-device camera ﬁ GPT-4o Vision via Appwrite Function

Voice input, barcode scan, recent/favourite shortcuts

7-day AI-generated plans, festival-aware, dosha-aligned

Macro Rings

Animated donut chart: carbs/protein/fat/fibre

Calorie Budget

Dynamic goal based on TDEE + activity level

Zomato/Swiggy

Restaurant menu calorie lookup via cached data

Export

PDF nutrition report shareable with dietitian

10.2 Workout Module

Structured workout plans, video guidance, custom routine builder, exercise library, and wearable-aware calorie

calculation.

Feature

Library

Plans

Video

Custom

Description

500+ exercises with form cues, muscle groups, equipment

Beginner/intermediate/advanced, Indian home workouts

Hosted on Appwrite Storage, streamed in-app

Drag-and-drop routine builder, set/rep/rest configuration

Live Timer

Built-in rest timer with haptic + audio cues

Calorie Burn

MET-based calculation using user weight + duration

Progress

Personal records, volume charts, muscle group heatmap

10.3 Step Counter Module

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 28

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Persistent  pedometer  using  phone  accelerometer,  GPS  route  tracking,  step  challenges,  and  wearable  data

merge.

Feature

Description

Pedometer

Workmanager background isolate, fused with wearable data

Goal

Routes

Dynamic daily goal (10K default, adaptive)

GPS route map with offline tile cache

Weekly Chart

7-day bar chart with streak indicators

Challenges

Community 30-day challenges, leaderboards

Achievements

Badges: 1K, 5K, 10K, marathon, steps in rain

10.4 Sleep Tracker Module

Automated  sleep  detection  via  accelerometer  +  microphone,  sleep  stage  analysis,  quality  scoring,  and  AI

bedtime coaching.

Feature

Detection

Stages

Score

Description

Accelerometer movement + snore detection ﬁ stage estimation

Awake / REM / Light / Deep breakdown

0–100 quality score with trend

Smart Alarm

Wakes during light sleep phase ±30 min of target

Insights

Correlation with mood, exercise, food patterns

Bedtime Coach

Push notification 45 min before recommended bedtime

10.5 Water Intake Module

Hydration tracking with climate-aware goals, quick-add buttons, reminder system, and weather API integration.

Feature

Quick Add

Goal

Description

Glass (200ml), bottle (500ml), custom amount

Dynamic: base 2.5L + 250ml per workout + 200ml per heat notch

Reminders

Smart notifications every 2h (skips sleep window)

Widget

Home screen widget with live progress bar

Source Track

Tap water, filtered, coconut water, buttermilk

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 29

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 11
Advanced Feature Modules

AI · Ayurveda · Recipe Engine · WhatsApp Bot

11.1 AI Nutrition Scanner
On-device camera or gallery photo ﬁ cloud AI identifies food, estimates portion size, and logs macros. Works
via Appwrite Function calling GPT-4o Vision.

Feature

Detection

Portion

Description

GPT-4o Vision via Appwrite Function (no API key in app)

Plate size calibration, reference objects for scale

Confidence

Shows confidence %, allows manual override

Offline fallback

Local ML model (TFLite) for 200 common Indian foods

Barcode

flutter_barcode_scanner for packaged foods

11.2 Ayurveda Engine

Dosha analysis, Ayurvedic food classification, herb recommendations, and seasonal Ritucharya routines — all

offline.

Feature

Description

Dosha Quiz

25-question assessment ﬁ Vata/Pitta/Kapha profile

Food DB

Herbs

Each food tagged with dosha effects (increases/decreases/neutral)

400+ herbs with evidence level, preparation, contraindications

Ritucharya

Seasonal routine recommendations (6 Ritu)

Daily Dincharya

Personalized morning/evening routine

Nutrition overlay

Dosha tags shown on food log and meal plan screens

11.3 Recipe Engine

1,000+  Indian  recipes  with  nutritional  breakdown,  meal  plan  integration,  ingredient  scaling,  and  dosha

alignment.

Feature

Database

Filters

Description

1,000+ Indian recipes (bundled), 5,000+ via Appwrite

Vegetarian/vegan/jain/keto/diabetic-friendly/dosha

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 30

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Feature

Scaling

Nutrition

Description

Auto-scale ingredients for household size

Full macro/micro breakdown per serving

Meal plan

One-tap add to meal plan from recipe view

Shopping list

Auto-generate ingredient list for week plan

11.4 WhatsApp Bot Integration

Log food and water via WhatsApp messages. Users can text 'had dal rice for lunch' and the bot parses and logs

it.

Feature

NLP

Description

Appwrite Function + Claude API for intent parsing

Commands

Log food, log water, check steps, get summary

Language

Supports Hindi and English messages

Privacy

Setup

No message storage — processed and discarded

OTP verification links WhatsApp number to account

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 31

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 12
Health Monitoring Modules

BP · Glucose · SpO2 · ECG · Lab OCR

FitKarma's health monitoring suite covers chronic disease management, vital sign tracking, and clinical-grade

lab report parsing. All data is stored encrypted locally and synced to Appwrite with user consent.

12.1 Blood Pressure Tracker

Feature

Manual log

Description

Systolic/diastolic/pulse, arm, posture

Classification

AHA 2023 categories with colour-coded status

Trends

30-day chart, moving average, min/max

Medication correlation

Overlay BP-lowering medication adherence

Doctor report

PDF summary shareable via Appwrite Storage link

Emergency

Crisis reading (>180/120) triggers emergency alert

12.2 Blood Glucose Tracker

Feature

Types

Targets

Chart

Description

Fasting, post-meal, random, HbA1c

Customisable target ranges (diabetes/pre-diabetes/normal)

Scatter plot with meal markers

HbA1c estimator

Approximates 3-month average from daily readings

Insulin log

Optional insulin dose recording

12.3 SpO2 / Oxygen Saturation

Feature

Source

Alerts

Description

Wearable (Fitbit/Garmin) or manual

SpO2 < 95% triggers notification

Night view

Overnight SpO2 dip chart from wearable data

12.4 Lab Report OCR

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 32

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Feature

On-device

Parser

Description

ML Kit OCR processes report image offline

Pattern matching extracts 50+ standard lab values

ABHA sync

Results stored in ABHA personal health record

Trend

Compare same test across multiple reports

Doctor share

Encrypted link with expiry for doctor

12.5 Medication Tracker

Feature

Schedule

Reminders

Adherence

Interaction

Refill

Description

One-time, daily, weekly, custom intervals

Push notification with snooze

Streaks, adherence %, missed dose log

Basic drug interaction warnings (offline DB)

Pill count, refill reminder

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 33

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 13
Lifestyle & Wellness Modules

Mental Health · Period · Ayurveda · Meditation

13.1 Mental Health & Mood

Feature

Mood log

Journal

PHQ-9

GAD-7

Description

5-level emoji scale + 20 emotion tags

Rich text, encrypted at rest with HKDF key

Depression screening, scored, trended over time

Anxiety screening

Stress level

0–10 manual + correlation with sleep/steps

Mindfulness

Guided breathing, body scan, gratitude prompt

Crisis resource

Igateway to iCall, Vandrevala Foundation when PHQ-9 ‡ 15

13.2 Period & Reproductive Health

Feature

Cycle log

Prediction

Symptoms

Description

Start/end date, flow intensity, symptoms

ML period + ovulation prediction (on-device)

60+ symptom tags (PMS, cramps, mood, energy)

Fertility window

Ovulation window highlighting

Insights

Privacy

Export

Cycle length trends, irregularity alerts

All data AES-256-GCM encrypted with HKDF rose-class key

PDF cycle report for gynaecologist

13.3 Meditation & Mindfulness

Feature

Sessions

Timer

Breathing

Description

50+ guided meditations (bundled audio, just_audio)

Configurable timer with ambient sounds

Box, 4-7-8, Pranayama (Anulom Vilom, Kapalbhati)

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 34

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Feature

Streak

Description

Daily meditation streak with XP reward

Integration

Meditation logs affect mood score positively

13.4 Festival & Wedding Planner

Feature

Calendar

Description

Hindu festival calendar (200+ events), fasting days

Fasting plan

Navratri, Karva Chauth, Ekadashi nutrition adapters

Wedding

Reminders

12-week fitness + diet plan for bride/groom

Festival-aware workout adaptations (light yoga during fast)

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 35

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 14
Social & Community Modules

Feed · Challenges · Leaderboards · Groups

14.1 Social Feed

A privacy-first activity feed. Users control visibility per activity type. No personal health data is posted without

explicit opt-in.

// Feed visibility settings (per user, per activity type)
enum FeedVisibility { public, friendsOnly, private }

class FeedSettings {
  FeedVisibility steps;          // default: friendsOnly
  FeedVisibility workouts;       // default: friendsOnly
  FeedVisibility achievements;   // default: public
  FeedVisibility challenges;     // default: public
  FeedVisibility healthData;     // default: private (always — never auto-posted)
}

14.2 Community Challenges

Feature

Types

Duration

Join

Progress

Rewards

Festive

Description

Steps, calorie burn, workout frequency, hydration, sleep score

Daily, weekly, 30-day, custom

Public join or invite-only (code)

Real-time leaderboard, progress bar, rank badge

XP multiplier + exclusive Karma badge on completion

Navratri Dance Steps challenge, IPL Walking challenge

14.3 Leaderboards

Feature

Scope

Metric

Update

Privacy

Description

Global, city-based, friends-only, group

Steps, active minutes, streak, Karma points

Real-time via Appwrite Realtime subscription

Leaderboard uses display name, never full name

Anonymous

Option to appear as 'Anonymous Warrior'

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 36

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

14.4 Workout Partner

Feature

Match

Description

Match by city, fitness level, language, goal

Accountability

Shared streak tracker, nudge notifications

Chat

Safety

Text chat via Appwrite Database (no third-party chat SDK)

Block/report feature, moderation queue

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 37

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Notifications · Widgets · Connectivity

§ 15
Platform & Infrastructure

15.1 Push Notifications

Feature

Provider

Delivery

Types

Smart

Description

FCM token via firebase_messaging — no Firebase DB

Token stored in Appwrite users collection

Streak at-risk, reminder, challenge update, insight, refill

Skips notifications during sleep window (22:00–07:00 IST default)

Low data

FCM payload-only (no images) when Low Data Mode enabled

15.2 Home Screen Widgets

Feature

Android

iOS

Sizes

Update

Description

Glance API via home_widget package

WidgetKit via home_widget package

2×2 (stats ring), 2×1 (Karma), 1×1 (streak)

Triggered after each sync cycle, max 15-min refresh

Dark/Light

Respects system theme, orange/teal brand colours

15.3 Connectivity Management

Feature

Detection

Description

connectivity_plus package

Low Data Mode

Toggle in Settings ﬁ Data & Sync

Adaptations

No blur, no images, text-only feed, no video

Banner

Persistent teal pill 'Low Data Mode'

2G support

All core functions work on 2G via local Drift reads

15.4 Remote Config

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 38

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Feature

Storage

Fields

Fetch

Offline

No SDK

Description

Appwrite 'remote_config' collection

Feature flags, insight rules, A/B variants, announcement

On app foreground, max 30-min cache

Last-fetched config persisted in Drift

Custom implementation — no Firebase RC dependency

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 39

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 16
Security & Privacy

AES-256-GCM · HKDF · Biometrics · GDPR

16.1 Encryption Architecture

FitKarma  uses  a  multi-layer  encryption  model.  The  master  key  lives  in  the  device  secure  enclave

(flutter_secure_storage). Per-class keys are derived using HKDF, so compromise of one class does not expose

others.

// Key hierarchy
Master Key (device secure enclave)
    n
    nnn HKDF("database") ﬁ SQLCipher database key
    nnn HKDF("medical")  ﬁ BP, Glucose, SpO2, Medication data
    nnn HKDF("reproductive") ﬁ Period, Pregnancy data
    nnn HKDF("journal")  ﬁ Mental health journal entries
    nnn HKDF("sync")     ﬁ Encrypted sync payload keys

// HKDF derivation (lib/core/services/encryption_service.dart)
Uint8List deriveKey(String context) {
  final masterKey = secureStorage.read(key: 'master_key');
  return Hkdf(
    hmac: Hmac.sha256(),
    outputLength: 32,
  ).deriveKey(
    secretKey: SecretKey(masterKey),
    info: utf8.encode(context),
  );
}

// AES-256-GCM encryption
Future<EncryptedData> encrypt(Uint8List plaintext, String keyClass) async {
  final key = await deriveKey(keyClass);
  final iv = SecretKey(Fortuna().nextBytes(12));  // 96-bit IV
  final secretBox = await AesCtr.with256bits(
    macAlgorithm: Hmac.sha256(),
  ).encryptSync(plaintext, secretKey: SecretKey(key), nonce: iv.extractBytes());
  return EncryptedData(ciphertext: secretBox.cipherText, iv: iv.extractBytes(), mac: secretBox.mac.bytes);
}

Data Class

Food logs

Encryption

Storage

Sync

None (low sensitivity)

Drift plain

Appwrite DB

Step counts

None

Drift plain

Appwrite DB

BP / Glucose

AES-256-GCM (medical)

Drift encrypted field

Encrypted payload

Journal entries

AES-256-GCM (journal)

Drift encrypted field

Encrypted payload

Period data

AES-256-GCM

(reproductive)

Drift encrypted field

Encrypted payload

Mental health

AES-256-GCM (journal)

Drift encrypted field

Encrypted payload

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 40

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Data Class

Encryption

Storage

Sync

ABHA token

flutter_secure_storage

Keychain/Keystore

Never synced

16.2 Privacy Principles

(cid:127) No advertising SDKs — ever. No Firebase Analytics, AdMob, or third-party tracking.

(cid:127) No data sold to third parties. User data is used only to provide the service.

(cid:127) Data portability: Users can export all their data as JSON from Settings ﬁ Data & Sync.

(cid:127) Right to erasure: Users can delete all data and account from Settings ﬁ Privacy ﬁ Delete Data.

(cid:127) Minimal data collection: Only data required for features is collected.

(cid:127) ABHA consent: Each health record access from ABHA requires explicit user consent per request.

(cid:127) biometricLock: Sensitive screens re-authenticate with fingerprint/Face ID on each entry.

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 41

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 17
External API Integrations

Fitbit · Razorpay · ABHA · NHA

Integration

Auth

Data Retrieved

Offline Behaviour

Fitbit API

OAuth 2.0 PKCE

Steps, HR, sleep, SpO2

Garmin Connect

OAuth 1.0a

Steps, HR, GPS routes

Apple HealthKit

iOS permission

All HealthKit metrics

Google Fit

OAuth 2.0

Steps, HR, weight

Last-synced  data  from

Drift

Last-synced  data  from

Drift

CoreData  bridge  —

always local

Last-synced  data  from

Drift

Razorpay

API

Key

(backend)

Subscription status

Cached tier in Drift

ABHA / NHA

OAuth + OTP

Health records, lab results

Zomato (cached)

No API — cached

DB

Restaurant menu calories

Cached

consent

in

Drift

Full  offline  —  bundled

DB

FCM (push only)

Firebase SA

Delivery tokens only

No functionality impact

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 42

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 18
Performance Contracts

SLAs · Benchmarks · Battery · App Size

Metric

Target

Measurement Method

APK size (arm64-v8a)

< 50 MB

CI/CD  build  size  check  —

fails  build

if

exceeded

Cold start (P95)

< 2 seconds

Firebase Performance / manual stopwatch

Dashboard render (P95)

< 1 second

Flutter DevTools frame timing

Food search latency

< 300 ms

Drift FTS5 full-text search benchmark

Sync cycle (50 items)

< 5 seconds

Integration test with mock Appwrite

Background step tracking

< 3% battery/hr

Android Battery Historian

Blur frame rate (mid-tier)

> 58 fps

Flutter DevTools (no janky frames)

Offline availability

100% core features

Airplane mode integration test

Encryption overhead

< 5 ms per field

Dart benchmark harness

18.1 App Size Enforcement

# CI/CD size check (.github/workflows/ci.yml)
- run: |
    SIZE=$(du -sm build/app/outputs/flutter-apk/app-arm64-v8a-release.apk | cut -f1)
    echo "APK size: ${SIZE} MB"
    if [ $SIZE -gt 50 ]; then echo "ERROR: APK exceeds 50 MB" && exit 1; fi

18.2 Performance Budget — UI

Render Context

Frame Budget

Technique

Dashboard (cold)

1s total

Optimistic Drift reads, no skeleton loaders

60 fps scroll

16.67 ms/frame

const constructors, RepaintBoundary on cards

Glassmorphism blur

Max  12px  blur

radius

Tier-gate: disabled on low, reduced on mid

Image loading

< 200 ms

CachedNetworkImage + Drift-cached URLs

Chart render (1yr data)

< 300 ms

fl_chart decimation, off-main-thread calc

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 43

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 19
State Management

Riverpod 2.x Patterns · Providers · Code-Gen

19.1 Provider Types Used

Provider Type

Use Case

Example

Provider

Static singleton services

appwriteClientProvider, databaseProvider

StateProvider

Simple UI state

selectedMealTypeProvider, isLoadingProvider

FutureProvider

One-shot async data

userProfileProvider, subscriptionProvider

StreamProvider

Reactive DB streams

todayFoodLogsProvider (Drift .watch())

AsyncNotifierProvider

Complex async actions

FoodLogNotifier (log, update, delete)

NotifierProvider

Sync state with actions

ThemeNotifier, KarmaNotifier

FamilyProvider

Parameterised providers

stepLogsForDateProvider(date)

19.2 Provider Example — Food Log

// lib/features/nutrition/presentation/providers/food_log_provider.dart
@riverpod
class FoodLogNotifier extends _$FoodLogNotifier {
  @override
  FutureOr<List<FoodLog>> build() {
    // Subscribe to Drift stream — auto-rebuilds on any DB change
    final userId = ref.watch(currentUserProvider).value?.id ?? '';
    return ref.watch(databaseProvider)
      .foodLogDao
      .watchTodayLogs(userId)
      .first;
  }

  Future<void> logFood(FoodLogCompanion entry) async {
    final db = ref.read(databaseProvider);
    final syncEngine = ref.read(syncEngineProvider);

    // 1. Write to Drift immediately (optimistic)
    final id = await db.foodLogDao.insertLog(entry);

    // 2. Queue for Appwrite sync
    await syncEngine.enqueue(
      operation: SyncOperation.create,
      collection: 'food_logs',
      payload: entry.toJson()..['$id'] = entry.syncId.value,
    );

    // 3. Award Karma XP
    ref.read(karmaNotifierProvider.notifier).awardXP(XPEvent.foodLogged);
  }
}

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 44

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 20
Monetization & Subscriptions

Razorpay · Plans · Karma Economy

20.1 Subscription Plans

Plan

Free

Price

n0

Billing

N/A

Pro Monthly

n99/month

Monthly auto-renew

Features

Core

tracking,  30-day  history,  basic

insights

All features, unlimited history, AI scanner,

wearables

Pro Yearly

n799/year

Annual auto-renew

All Pro features + 33% saving vs monthly

Lifetime

n1,999 one-time

One-time purchase

All  Pro  features  forever,  future  features

included

20.2 Karma Economy

Action

Log any meal

Log water

XP Awarded

Notes

+5 XP

+2 XP

Up to 3×/day

Up to 8×/day

Complete step goal

+20 XP

Daily

Workout session

+25 XP

Per session

7-day streak

30-day streak

Log blood pressure

Complete challenge

Lab report upload

Journal entry

Refer a friend

+100 XP

Bonus

+500 XP

Milestone

+10 XP

+200 XP

+30 XP

+8 XP

Daily

+150 XP

On first login

20.3 Karma Levels

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 45

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Level

Title

XP Required

1

2

3

4

5

6

7

8

9

10

Seedling

Sprout

Sapling

Warrior

Champion

Master

Guardian

Legend

Immortal

FitGuru

0

250

600

1200

2500

5000

10000

20000

50000

100000

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 46

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 21
Testing Strategy

Unit · Widget · Integration · Golden

21.1 Test Coverage Targets

Layer

Target Coverage

Framework

Domain / business logic

Drift DAOs

Riverpod providers

> 90%

> 85%

> 80%

dart test

dart test with in-memory DB

flutter_riverpod test helpers

Widget smoke tests

100% screens

flutter_test

Golden / screenshot

Critical screens

alchemist / golden_toolkit

Integration (E2E)

Core user flows

flutter integration_test

Sync engine

> 95%

Unit test with mock Appwrite

21.2 Unit Test Example

// test/features/nutrition/food_log_notifier_test.dart
void main() {
  late ProviderContainer container;
  late MockFoodLogDao mockDao;

  setUp(() {
    mockDao = MockFoodLogDao();
    container = ProviderContainer(overrides: [
      foodLogDaoProvider.overrideWithValue(mockDao),
      currentUserProvider.overrideWithValue(AsyncData(testUser)),
    ]);
  });

  test('logFood writes to Drift and queues sync', () async {
    // Arrange
    when(() => mockDao.insertLog(any())).thenAnswer((_) async => 1);
    final notifier = container.read(foodLogNotifierProvider.notifier);

    // Act
    await notifier.logFood(testFoodLogCompanion);

    // Assert
    verify(() => mockDao.insertLog(testFoodLogCompanion)).called(1);
    final queue = container.read(syncQueueProvider);
    expect(queue.length, 1);
    expect(queue.first.collection, 'food_logs');
  });
}

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 47

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Dart · Architecture · Naming Conventions

§ 22
Coding Standards

22.1 Naming Conventions

Element

Files

Classes

Variables

Constants

Providers

Convention

Example

snake_case

food_log_screen.dart

PascalCase

FoodLogNotifier

camelCase

totalCalories

camelCase const

defaultDailyStepGoal

camelCase  +  Provider

suffix

foodLogNotifierProvider

Riverpod gen

@riverpod annotation

@riverpod class FoodLogNotifier

Drift tables

DAOs

Enums

PascalCase  +  Table

suffix

FoodLogTable

PascalCase + Dao suffix

FoodLogDao

PascalCase values

enum MealType { breakfast, lunch }

22.2 Key Rules

(cid:127) Never hardcode hex values — always use AppTokens.primary etc.

(cid:127) All UI rebuilds must be driven by Riverpod watches — no setState in feature screens.

(cid:127) No direct Appwrite SDK calls in widgets — always go through repositories.

(cid:127) Encrypted fields must never be logged (print/debugPrint) in any build mode.

(cid:127) All async providers must handle loading, data, and error states explicitly.

(cid:127) const constructors on all stateless widgets — enforced by flutter_lints.

(cid:127) No platform-specific code in feature modules — use abstraction in core/.

(cid:127) All monetary amounts in paise (integer) — never floating-point for currency.

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 48

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 23
Environment Configuration

Secrets · .env · RemoteConfig

23.1 .env Files

# .env.prod — never committed, injected by CI/CD
APPWRITE_ENDPOINT=https://cloud.appwrite.io/v1
APPWRITE_PROJECT_ID=xxxx
APPWRITE_DATABASE_ID=yyyy
RAZORPAY_KEY_ID=rzp_live_xxxx
FITBIT_CLIENT_ID=zzzz
SENTRY_DSN=https://....@sentry.io/...

# .env.staging
APPWRITE_ENDPOINT=https://staging.appwrite.io/v1
APPWRITE_PROJECT_ID=staging_xxxx
RAZORPAY_KEY_ID=rzp_test_xxxx

23.2 RemoteConfig Flags

Flag

Type

Default

Purpose

aiScannerEnabled

boolean

glassBlurEnabled

boolean

true

true

Toggle AI food scanner globally

Override device-tier glass blur

whatsappBotEnabled

boolean

false

Gradual WhatsApp bot rollout

abhaEnabled

boolean

festivalMode

proMonthlyPrice

insightRules

string

integer

json

true

null

99

[]

Toggle ABHA integration

Active festival name (e.g. 'navratri')

Dynamic pricing in INR

Server-updated insight detection rules

maintenanceMode

boolean

false

Show maintenance banner

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 49

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

GitHub Actions · Backup · Admin Dashboard

§ 24
CI/CD Pipeline

24.1 Pipeline Overview

Stage

test

Trigger

Runner

Actions

All PRs + push

ubuntu-latest

flutter analyze, flutter test --coverage

check_app_size

After test

ubuntu-latest

Build APK, assert < 50 MB

build_android

main branch only

ubuntu-latest

flutter build appbundle

build_ios

main branch only

macos-latest

flutter build ipa (code-signed)

deploy_staging

develop branch

ubuntu-latest

appwrite deploy function --all

24.2 GitHub Secrets Required

APPWRITE_PROJECT_ID               — Production Appwrite project ID
APPWRITE_DATABASE_ID              — Production database ID
APPWRITE_STAGING_PROJECT_ID       — Staging project ID
APPWRITE_STAGING_ENDPOINT         — Staging endpoint URL
RAZORPAY_KEY_ID                   — Live Razorpay key
FITBIT_CLIENT_ID                  — Fitbit app client ID
IOS_DIST_CERT_P12                 — iOS distribution certificate
IOS_DIST_CERT_PASSWORD            — Certificate password
APPSTORE_ISSUER_ID                — App Store Connect issuer
APPSTORE_KEY_ID                   — App Store Connect key ID
APPSTORE_PRIVATE_KEY              — App Store Connect private key

24.3 Disaster Recovery

# Daily backup cron — 02:00 IST
0 20 * * * appwrite databases export \
  --databaseId $DATABASE_ID \
  --output /backups/fitkarma-$(date +%Y%m%d).json \
  && rclone copy /backups/ b2:fitkarma-backups/

# Retention: 30 daily backups; 12 monthly backups
# Storage: Backblaze B2
# Recovery test: Monthly restore drill in staging

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 50

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ UI
App Demo — Screen Gallery

45+ Annotated Mockups

The  following  pages  present  rendered  UI  mockups  for  all  major  FitKarma  screens.  Each  mockup  faithfully

represents the design tokens, layout patterns, glassmorphism surfaces, and component hierarchy described in

the UI Design System. Dark mode is shown unless otherwise noted.

Onboarding & Authentication Screens

FK

FitKarma

India's Fitness Platform

Offline-First · Privacy-Centric

n

Your Fitness Journey
India's most affordable
health companion

Get Started  ﬁ

Sign In

Figure UI-1 · Splash screen with spring-animated logo reveal (Rive) and onboarding welcome with progress dots

Splash / Logo Screen

Welcome Onboarding (Slide 1)

Main Dashboard & Karma

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 51

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

FitKarma
Namaste, Rahul n

R

1,247

Karma Points  (cid:127)  Level 8

Today's Activity

82%

Steps

61%

Active

45%

Cal

7,842

1.8L

Steps  / 10K goal

Water  / 2.5L

78% complete

72% of goal

n Insight

You sleep better after yoga days.
n
Pattern over 14 days detected.

n

n

n

n

Home

Food

Workout

Health

Profile

The  dashboard  is  the  heart  of  FitKarma.  It  uses  a  bento-grid  layout  with  the  Karma  hero  card  at  top,  activity
Main Dashboard

rings,  quick-stat  mini-cards  (Steps,  Water),  and  an  AI  insights  card.  The  orange-accented  nav  bar  is  always

visible.

Figure UI-2 · Dashboard: Karma hero card, activity rings, bento quick-stats, AI insight card

Food & Nutrition Screens

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 52

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Food Log
nn nn nnnn

1,840

kcal  /  2200 goal

Nutrition AI

n

Carbs

Protein

Fat

Tap to scan food with camera

Breakfast  n
Poha, Tea

Lunch  nn
Dal Rice, Raita

Snack  nn
Fruits, Chai

412 kcal

680 kcal

220 kcal+

3 Dal Makhani detected
482 kcal
Confidence: 94%  ·  Portion: 1 bowl (~280g)

56g

Carbs

22g

18g

Protein

Fat

8g

Fibre

+ Log this meal

n Pitta-balancing  ·  Kapha-increasing

Figure UI-3 · Food log with macro rings and meal sections · AI scanner with detection confidence

Food Log Screen

AI Nutrition Scanner

Workout Screens

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 53

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Workout
nnnnnnn

n  Start Today's Workout

Upper Body · 45 min

All

Yoga

HIIT

Strength

Cardio

n
Surya Namaskar

n
HIIT Blast

Yoga

20 min

HIIT

30 min

n
n
n
Push-Pull

n

n
n
Morning Run
Health

n

Profile

Home

Food

Workout

Strength

45 min

Cardio

35 min

The  workout  screen

features  a  hero  gradient  card

Workout Library & Start

for

today's  recommended  session,

filter  chips

(Yoga/HIIT/Strength/Cardio), and a 2-column grid of workout cards with category, duration, and emoji icons.

Figure UI-4 · Workout library with filter chips, category cards, and today's workout hero CTA

Steps, Activity & Hydration

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 54

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Steps & Activity

Water Intake

1.8L

of 2.5L goal  ·  72%

Glass

200ml

Bottle

500ml

Custom

Today's Log

n 300 ml

n 200 ml

09:00

11:30

7,842

/ 10,000 steps

78% of daily goal

5.8 km

312

48 min

Distance

Calories

Active

Weekly Steps

Mon

Tue Wed

Thu

Fri

Sat

Sun

Figure UI-5 · Steps screen with large progress ring and 7-day bar chart · Water screen with wave fill

Steps & Activity

Water Intake

Sleep Tracking

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 55

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Sleep
nnnn

7h 20m

Last Night  ·  Good

Sleep Stages

REM

Light

Deep

82

Sleep Score  ·  Good

Sleep uses a deep navy-indigo 3-stop hero gradient. A crescent moon illustration doubles as a phase indicator.
Sleep Tracker Screen

Sleep  stages  are  shown  as  a  segmented  bar  (Awake  /  REM  /  Light  /  Deep).  The  sleep  score  is  prominently

displayed at 36sp.

Figure UI-6 · Sleep screen: duration hero, stage bar, quality score with deep space gradient

Health Monitoring Dashboard

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 56

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Health
nnnnnnnnn

⁄n 72 bpm

n 118/78

Heart Rate

Normal

Blood Pressure

Normal

n 98 mg/dL

n 98%

Blood Glucose

SpO2

Normal

Normal

n 7h 20m

n Low

Sleep

Normal

Stress

Normal

Blood Pressure

118/78

mmHg  ·  Today 09:30
Normal

30-day Trend

Systolic

Diastolic

120/80

118/78

116/76

08:00

12:30

21:00

Figure UI-7 · Health hub with 6-vital bento grid · BP detail with 30-day trend chart

Blood Pressure Tracker

Health Overview

Mental Health & Wellness

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 57

‹
FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Mental Wellness

How are you feeling?

n

n

n

n

n

Happy

Meh

Low

Stressed

Tired

n 14-day streak!

Keep journaling daily

-n  Open Journal

PHQ-9 Score:  4 / 27

Minimal depression range  ·  Last: 3 days ago

Next check-in recommended in 7 days

Mental Health features a mood picker (5 emoji options), journal streak flame, PHQ-9 score card, and a journal
Mental Wellness Screen

CTA button. Indigo-purple tones differentiate it from the orange-primary fitness screens.

Figure UI-8 · Mental wellness: mood picker, streak counter, journal access, PHQ-9 summary

ABHA Integration & Lab Reports

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 58

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

ABHA Health ID
Ayushman Bharat Health Account

Lab Report OCR

n ABHA

Ayushman Bharat Health Account

14-digit ABHA Number

91-1234-5678-9012

Linked Health Records

2 days ago

1 week ago

n Lab Results

n Prescription

Data Consent

Apollo Hospital requested access

3 Approve

7 Deny

n  Scan lab report

Works offline  ·  On-device OCR

Parsed Results

Glucose

98 mg/dL

Normal

HbA1c

5.4%

Total Cholesterol192

Normal

Normal

TSH

2.8 mIU/L
n  Share with Doctor

Normal

Figure UI-9 · ABHA card with linked records and consent flow · Lab OCR with parsed values

Lab Report OCR

ABHA Health ID

Community, Festival & Period Tracker

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 59

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Community

Cycle Tracker
n nnnnnnn nnnnnn

n  October Step Challenge

8,432 participants  ·  Ends in 8 days

n

Your rank: #234  ·  6,834 steps today

Leaderboard

Navratri Fitness Plan
nnnnnnnn  ·  9 Days  ·  Starts in 3 days

Priya S.

12,450 steps

n  Navratri Fasting Plan
Kuttu flour, Sabudana, Fruit diet

Calorie target: 1400 kcal/day

Amit K.

11,820 steps

Activate Plan

n

n

n

Meera P.

10,930 steps

  #4 Rahul S.

6,834 steps

Priya just hit 12K steps! n

P

Celebrated Navratri with a dance workout

⁄n  48  n  12  (cid:127)  2h ago

n  Garba Fitness Mode
Light yoga, Dandiya movements

Avoid heavy lifting during fast days

D1

D2

D3

D4

D5

D6

D7

D8

D9

Day 8

Follicular

n  Next period in 20 days

Cycle: 28 days  ·  Flow: Medium

Today's Symptoms

n Cramps

n Mood swings
n Bloating

n Fatigue

Figure UI-10 · Social challenge banner with leaderboard · Navratri festival planner · Period cycle wheel
Festival Planner
Period Tracker

Community Feed

Profile, Settings & Wearables

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 60

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Rahul Sharma
Level 8 · Warrior
n 1,247 Karma

R

42

Days

28

5

Workouts

Goals

n Notifications

n Privacy

n Dark Mode

›

›

›

Settings

Devices & Sync

ACCOUNT

n  Profile & Goals

n  Achievements

n  Health Summary

APP

n  Dark Mode

n  Notifications

n  Language

n  Accessibility

PRIVACY

n  Biometric Lock

nn  Data & Sync

›

›

›

›

›

›

›

n Mi Band 8 Pro

l Connected  ·  Battery 82%

Last sync: 2 min ago

Steps

Heart Rate

Sleep

SpO2

Add Device

n Apple Health

iOS

n Google Fit
Android

n Fitbit
Any

n Garmin
Any

Link

Link

Link

Link

Figure UI-11 · Profile with Karma stats hero · Settings with toggle controls · Wearable device connection
Profile Screen
Device Sync
Settings Screen

nn  Delete Data

›

n Share Report

›

PREMIUM

n  FitKarma Pro

›

n Subscription

›

Subscription Plans & Home Widgets

n  Subscription

›

n  Restore Purchase

›

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 61

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

n

FitKarma Pro
Unlock your full potential

Monthly
n99/mo

BEST

Yearly
n799/yr

Save 33%

Lifetime
n1,999

3  AI Nutrition Scanner

Start Free Trial  ﬁ

Home Widgets

FitKarma  ·  Today

7,842
steps

312

Cal

1.8L

Water

7h

Sleep

Karma

Streak

1,247

pts

n 14

Level 8 Warrior

days active

Figure UI-12 · Pro subscription with pricing tiers · Android/iOS home widget gallery (2×2, 2×1, 1×1)

FitKarma Pro Plans

Home Screen Widgets

Shared Component Library

The following 28 shared components are available across all feature modules. They enforce design consistency

and are the building blocks of every screen.

Component

GlassCard

Description

Used in

BackdropFilter blur + glass overlay

All dashboard cards

GlowingMetric

Large number with drop-shadow glow

Dashboard, BP, Steps hero

ActivityRing

Animated SVG ring with CountUp

Dashboard, Steps, Profile

BentoGrid

Variable-size card grid layout

Dashboard, Health, Social

BilingualLabel

English + Hindi label row

All section headers

KarmaChip

Amber XP badge with animation

Dashboard, Log confirmations

StreakFlameWidget

Lottie fire animation

Dashboard, Social

MacroRingChart

3-ring donut for macros

Food log, Meal plan

GlassBottomSheet

Draggable glass sheet

All log actions

TrendChip

s/t/ﬁ trend indicator pill

BP, Glucose, Sleep score

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 62

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Component

InsightCard

Description

Used in

Secondary-glow correlation card

Dashboard, Health

SyncStatusBanner

Amber DLQ / Teal offline banners

Global scaffold

PrimaryButton

Full-width orange CTA

All primary actions

GlassTextField

Focus-glow input field

All log forms

EncryptionBadge

n lock icon badge

BP, Period, Journal screens

FoodCard

Food thumb + macros + bilingual

Search, Meal plan

WorkoutCard

Category icon + duration + level

Workout library

HealthValueRow

Label + value + status pill

Lab results, vitals

ProgressBar

Animated filled bar

Goals, steps, water

AvatarCircle

User initials + level ring

Profile, Social, Nav

DoshaTag

Teal Ayurveda classification

Food cards, Nutrition

DateScrollPicker

Horizontal date chips

All log screens

EmptyStateIllustration

Lottie empty states

All empty list states

ChipFilter

Scrollable filter chips

Workout, Food search

ShimmerCard

Shimmer loading placeholder

Remote content only

MoodEmoji

Animated emoji mood selector

Mood log screen

FestivalBanner

Ambient festival context card

Dashboard, Festival

QuickLogFab

Expandable speed dial FAB

Dashboard, Food, Water

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 63

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Accessibility & Bilingual Summary

FitKarma  meets  or  exceeds  WCAG  AA  contrast  requirements  for  all  text.  Bilingual  labelling  is  applied

strategically — not on every element — to maximise comprehension without cluttering the UI.

Standard

Requirement

FitKarma Implementation

WCAG AA contrast

4.5:1 minimum

All  text  meets  or  exceeds  —  glow  never  counted

toward ratio

Tap target

44×44px min

All buttons, chips, row icons enforced

Screen reader

Semantic labels

All IconButton + Image have Semantics

Font scaling

Respects system size

No hardcoded textScaleFactor overrides

Dyslexia font

OpenDyslexic option

Toggle in Settings ﬁ Preferences

High contrast mode

Zero gradients

Black/white/orange — all blur disabled

Motion reduce

No animations

Cross-fade fallback on disableAnimations

Bilingual labels

Strategic only

Nav, section headers, food names, lab values

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 64

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ APP
Appendix

Packages · Dependencies · Changelog

A. pubspec.yaml — Key Dependencies

dependencies:
  flutter_riverpod:        ^2.4.9
  riverpod_annotation:     ^2.3.3
  drift:                   ^2.14.1
  sqlite3_flutter_libs:    ^0.5.18
  appwrite:                ^11.0.1
  flutter_secure_storage:  ^9.0.0
  local_auth:              ^2.1.7
  workmanager:             ^0.5.0
  connectivity_plus:       ^5.0.2
  fl_chart:                ^0.66.0
  lottie:                  ^3.0.0
  rive:                    ^0.12.0
  google_fonts:            ^6.1.0
  razorpay_flutter:        ^1.3.7
  home_widget:             ^0.4.1
  firebase_messaging:      ^14.7.9   # FCM only
  sentry_flutter:          ^7.14.0
  cached_network_image:    ^3.3.1
  image_picker:            ^1.0.4
  flutter_barcode_scanner: ^1.0.0
  speech_to_text:          ^6.3.0
  health:                  ^9.0.0
  shimmer:                 ^3.0.0
  flutter_local_notifications: ^16.1.0
  url_launcher:            ^6.2.5
  pdf:                     ^3.10.0
  flutter_quill:           ^9.0.0
  just_audio:              ^0.9.0

B. Changelog Summary

Version

Key Changes

2.0.0

2.0.0

2.0.0

2.0.0

2.0.0

2.0.0

2.0.0

Sync engine upgraded: idempotency keys, DLQ, per-field version vectors

Encryption re-architected: HKDF per data class stored in Drift (SQLCipher)

First-class RemoteConfig system added (Appwrite-backed)

Insight engine modularised with server-updatable rules

India-specific: ABHA, Lab Report OCR, shareable doctor reports

Home screen widgets: Android Glance + iOS WidgetKit

WhatsApp bot integration for food/water logging

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 65

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Version

Key Changes

2.0.0

2.0.0

2.0.0

2.0.0

2.0.0

2.0.0

1.5.0

1.4.0

1.3.0

1.2.0

1.1.0

1.0.0

Full dark mode token set + light mode warm inversion

Offline map tile caching for workout routes

Glassmorphism UI: bento-grid, spring physics, Lottie/Rive animations

Festival planner: Navratri, Karva Chauth, Ekadashi fasting adapters

iOS CI/CD: code signing, App Store Connect provisioning

Staging Appwrite deploy pipeline added

Razorpay subscription billing, Karma economy system

Mental health: PHQ-9, GAD-7, encrypted journal

Period tracker with ML cycle prediction

Fitbit/Garmin/Apple Health/Google Fit wearable sync

Ayurveda engine: dosha quiz, food tagging, herb DB

Initial release: nutrition, workout, steps, sleep, water

FitKarma — Developer & UI Documentation

India's Most Affordable, Culturally-Rich Fitness Platform

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Offline-First  ·  Privacy-Centric  ·  35+ Modules  ·  45+ Screens

Full Bilingual UI  ·  Dark-First Design  ·  28 Shared Components

ABHA Integration  ·  Lab Report OCR  ·  Ayurveda Engine  ·  WhatsApp Bot

© 2025 FitKarma Engineering — All rights reserved

Documentation Version 2.0  ·  For internal and developer use

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 66

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

150 pages · 24 chapters

§ TOC
Table of Contents

§ 1    Project Overview

Architecture, Principles, Tech Stack

§ 2    UI Design Reference

Colour Tokens, Glassmorphism, Typography

§ 3    Application Architecture

Layer Diagram, Component Map

§ 4    Folder Structure

Complete Module Tree

§ 5    Appwrite Setup

Collections, Indexes, Functions

§ 6    Database Schema

All 25+ Collections with Attributes

§ 7    Local Storage — Drift

Tables, DAOs, Encryption

§ 8    Offline Sync Architecture

Idempotency, Dead-Letter Queue, Vectors

§ 9    Authentication & Onboarding

Phone OTP, Google, ABHA, Biometrics

§ 10    Core Feature Modules

Nutrition, Workout, Steps, Sleep, Water

§ 11    Advanced Features

AI Scanner, Ayurveda, Recipe Engine

§ 12    Health Monitoring

BP, Glucose, SpO2, ECG, Lab OCR

§ 13    Lifestyle & Wellness

Meditation, Journal, Stress, Period

§ 14    Social & Community

Feed, Challenges, Leaderboards

§ 15    Platform & Infrastructure

Notifications, Widgets, WhatsApp Bot

§ 16    Security & Privacy

Encryption, Biometrics, GDPR

§ 17    External API Integrations
Fitbit, Razorpay, ABHA, Zomato

§ 18    Performance Contracts
SLAs, Benchmarks, Battery

§ 19    State Management

Riverpod Patterns, Providers

§ 20    Monetization & Subscriptions
Razorpay, Plans, Karma Economy

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 67

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 21    Testing Strategy

Unit, Widget, Integration, Golden

§ 22    Coding Standards

Dart Conventions, Architecture Rules

§ 23    Environment Configuration
Secrets, .env, RemoteConfig

§ 24    CI/CD Pipeline

GitHub Actions, Backup, Admin Dashboard

§ UI    App Demo — Screen Gallery

45+ Annotated UI Mockups

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 68

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

India's Fitness Platform

§ 1
Project Overview

1.1 App Identity

Property

App Name

Tagline

Bundle ID

Architecture

Tech Stack

Target Market

Languages

Value

FitKarma

India's Most Affordable, Culturally-Rich Fitness App

com.fitkarma.app

Offline-first, server-synced via Appwrite

Flutter 3.x · Riverpod 2.x · Drift (SQLite) · Appwrite

Indian users across all connectivity tiers (2G–5G)

English + 22 Indian regional languages

App Size Target

< 50 MB (enforced in CI/CD)

Dashboard Load

< 1 second

Feature Modules

Screens

35+

45+

1.2 Design Principles

n Offline-first

All writes go to Drift instantly; Appwrite is only touched during sync. Zero loading states for core actions.

n Zero recurring API costs

Critical data paths never depend on external APIs at runtime.

n Privacy-first

AES-256-GCM encrypted medical and reproductive health data with HKDF per data class. No advertising SDKs.

No data sold to third parties.

n Culturally rich

Indian  food  database,  Ayurveda  engine,  ABHA  integration,  festival  calendar,  and  regional  language  support

baked in.

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 69

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

n Performance

Sub-50  MB  install  size,  <2s  cold  start,  <1s  dashboard  render,  <3%  battery  drain  per  hour  during  background

tracking.

n Single backend

Appwrite replaces all Firebase dependencies. No Firebase SDK except firebase_messaging for push tokens.

n Comprehensive health coverage

Blood  pressure,  glucose,  lab  report  OCR,  mental  health,  wearable  sync,  meal  planning,  and  chronic  disease

management modules.

n Accessible

Screen reader, font scaling, full dark mode, and high-contrast mode support built in.

n India-ecosystem integrated

ABHA health ID linking, UPI deep-links, WhatsApp bot logging, Zomato/Swiggy restaurant calories, lab report

OCR.

1.3 Device Tier System
FitKarma runs on devices from n6,000 budget phones to flagship handsets. The UI degrades gracefully across
three tiers:

Tier

Low

Mid

High

RAM

Glassmorphism

Animations

< 3 GB

Disabled

Simplified fades

3–6 GB

Enabled (reduced)

Spring physics

> 6 GB

Full + glow

All effects

Blur

Disabled

12px cap

Full

1.4 Technology Stack

Layer

UI

State

Technology

Flutter 3.x

Riverpod 2.x

Purpose

Cross-platform rendering with 45+ screens

Reactive DI, async state, code-gen providers

Local DB

Drift (SQLCipher)

Type-safe SQLite with AES-256 encryption

Backend

Appwrite

Auth, Database, Storage, Functions, Realtime

Payments

Razorpay

Subscription billing, UPI, cards, wallets

Push

Firebase Messaging

FCM token only — no other Firebase SDK

Analytics

Sentry

Crash reporting and performance monitoring

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 70

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Layer

Technology

Purpose

Animation

Lottie + Rive

Streak fire, confetti, logo reveal, level-up

Fonts

Plus  Jakarta  Sans  +  JetBrains

Mono

Variable weight UI + metric monospace

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 71

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Design System & Visual Language

§ 2
UI Design Reference

2.1 Design Philosophy

Pillar

Engineering Implication

Spatial Depth

Fluid Motion

Bold Information

Three-layer surface model (bg ﬁ cards ﬁ foreground). BackdropFilter blur on
all Plane 2 cards — tier-gated.

Spring  physics  via  SpringDescription  on  all  transitions.  Zero  linear  tweens.

Tier-gated: low-end uses simplified fades.

Metric  numbers  render  at  56–72sp  with  JetBrains  Mono  variable  font.  One

dominant metric per screen.

Visual Restraint

Not every surface blurs. Not every card glows. Glow is a reward, not a default.

Dark-First

Dark  mode  is  the  primary  design  target.  Light  mode  is  a  deliberate  warm

inversion.

Cultural Pulse

Bilingual labels, Indian units, festival context, and ABHA integration are core.

2.2 Dark Mode Colour Tokens

Dark mode is the design baseline. All implementations start here.

Token

Hex

Usage

bg0

bg1

bg2

surface0

surface1

surface2

primary

accent

#080810

Deepest base layer — shows at screen edges

#0F0F1A

Primary scaffold background

#161625

Secondary/nested screen background

#1C1C2E

Base card surface

#22223A

Elevated cards, bottom sheets

#2A2A45

Tooltips, pop-overs

#FF6B35

CTAs, FAB, active nav, ring fill — vibrant orange

#FFB547

Karma XP, streaks, insight card highlights

secondary

#7B6FF0

Hero accents, level badges, progress fills

teal

#00D4B4

Water, SpO2, Ayurveda, Medication

success

#4ADE80

Steps rings, habits, healthy readings

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 72

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Token

warning

error

rose

purple

Hex

Usage

#FBBF24

Elevated readings, moderate risk

#F87171

Crisis readings, destructive actions

#FB7185

Period cycle, menstrual accent

#C084FC

Active minutes ring

textPrimary

#F1F0FF

Headings, primary body

textSecondary

#9B99CC

Labels, subtitles, captions

textMuted

#6B68A0

Placeholders, inactive states — decorative only

bg0
#080810

bg1
#0F0F1A

surface0
#1C1C2E

surface1
#22223A

primary
#FF6B35

accent
#FFB547

secondary
#7B6FF0

teal
#00D4B4

Figure 2.1 — Dark Mode Brand Colour Palette

success
#4ADE80

warning
#FBBF24

error
#F87171

rose
#FB7185

2.3 Light Mode Colour Tokens

Token

Hex

Notes

bg0

bg1

#F7F0E8

Warm parchment — deepest background

#FDF6EC

Primary scaffold background

surface0

#FFFFFF

Card surface

primary

#F4511E

Slightly deeper orange — better contrast on light

primaryMuted

#FEE8E2

Chip selected background

accent

#F59E0B

Karma coins

secondary

#5B50D4

Hero sections, level badges

teal

#0D9488

Water, Ayurveda

success

#22C55E

Healthy readings

textPrimary

#1A1830

All body copy

textSecondary

#6B6A96

Subtitles, labels

bg0
#F7F0E8

bg1
#FDF6EC

surface0
#FFFFFF

primary
#F4511E

accent
#F59E0B

secondary
#5B50D4

teal
#0D9488

Figure 2.2 — Light Mode Colour Palette

success
#22C55E

textPrimary
#1A1830

textSecondary
#6B6A96

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 73

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

2.4 Glassmorphism Recipe

Applied to all card widgets (Plane 2 surfaces) in dark mode on Tier: mid/high devices:

/* Flutter equivalent: ClipRRect + BackdropFilter + Container */
/* Dark Mode Glass */
background: rgba(255, 255, 255, 0.05);
border: 1px solid rgba(255, 255, 255, 0.10);
backdrop-filter: blur(12px) saturate(180%);
border-radius: 20px;

/* Light Mode Glass */
background: rgba(255, 252, 248, 0.80);
border: 1px solid rgba(244, 81, 30, 0.12);
backdrop-filter: blur(12px);   /* CAPPED at 12px — never 20px in light mode */

2.5 Typography System

Style

Font

Size

Weight

Usage

displayLg

Plus Jakarta Sans

56–72sp

ExtraBold 800

displayMd

JetBrains Mono

40–48sp

Bold

Hero  metrics,  Karma

score

Step

count,

calorie

total

h1

h2

h3

h4

body1

body2

caption

hindi

Plus Jakarta Sans

Plus Jakarta Sans

Plus Jakarta Sans

Plus Jakarta Sans

Plus Jakarta Sans

Plus Jakarta Sans

Plus Jakarta Sans

Plus Jakarta Sans

monoLg

JetBrains Mono

monoSm

JetBrains Mono

2.6 Hero Gradients

28sp

22sp

17sp

14sp

15sp

13sp

12sp

11sp

24sp

12sp

Bold 700

Screen titles

SemiBold 600

Section headings

SemiBold 600

Sub-sections

Medium 500

Card titles

Regular 400

Primary body text

Regular 400

Secondary body

Regular 400

Labels, timestamps

Regular 400

Hindi sub-labels

Bold

Metrics, vitals

Regular

Code, data

Name

Direction

Dark Mode

Used on

heroDeep

135°

#0A0818 ﬁ #1E1850

Dashboard, Karma, Profile

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 74

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Name

Direction

Dark Mode

Used on

heroSleep

180° (3-stop)

#04020F ﬁ #0D0B2E ﬁ #1C1A48

Sleep screen

heroFestival

heroWedding

heroPrimary

120°

135°

135°

#1A0A00 ﬁ #3D1500

#1A1000 ﬁ #3A2800

#1A0800 ﬁ #3D1100

Festival screens

Wedding planner

Workout, Steps

2.7 Bento Grid System

The  bento  grid  is  the  primary  layout  pattern  for  dashboard-style  screens.  Cards  of  varied  sizes  create  visual

rhythm.

// Grid definitions
nnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
n  Hero Card      n  Square  n   Row 1: 2/3 + 1/3
n  (2/3 width)    n  (1/3)   n
nnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
n  Small n  Small n  Small   n   Row 2: thirds
n  (1/3) n  (1/3) n  (1/3)   n
nnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
n  Wide (2/3)     n  Tall    n   Row 3: mixed
nnnnnnnnnnnnnnnnnnnnnnnnnnnnnn

// Gutter: 12px uniform  |  Radius: 20px standard  |  Corner XL: 28px  (hero)

2.8 Animation System

Context

Spec

Notes

Page transitions

Spring:

stiffness=100,

damping=14

Horizontal slide + scale 0.96ﬁ1.0

Bottom sheet entrance

Spring:

stiffness=260,

damping=24

Slide from bottom with bounce

FAB tap

Scale 0.92ﬁ1.0, 120ms

Haptic feedback on confirm

Ring fill (steps/activity)

Staggered 600ms, delay 200ms

CountUp on entry

XP float on log

Level-up

Streak fire

amber  +X  XP

floats  48px,

500ms

coin_burst Lottie, fade out

Full-screen

indigo  overlay  +

confetti

Spring entrance displayLg

Lottie: streak_fire, size scales

Orange banner, size (cid:181) count

Card hover/tap

Scale 0.97, duration 180ms

All tappable cards

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 75

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Context

Spec

Notes

Reduced motion

Cross-fade fallback

AccessibilityFeatures.disableAnimations

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 76

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 3
Application Architecture

Layers · Components · Data Flow

3.1 System Architecture Overview

FitKarma — System Architecture

Flutter UI

45+ Screens

Widgets

Shared 28+

Animations

Rive/Lottie

Themes

Dark/Light

Nav

GoRouter

UI Layer

Riverpod

Providers

NotifyProv

Async Notif

StateNotif

Stream/Future

RemoteConf

Feature Flags

DI

Ref.watch

State Layer

Drift/SQLCipher

Local DB+Enc

SyncEngine

Idempotent

DLQ

HKDF

Dead Letter Q

Per-Class Enc

Cache

Tile/Media

Appwrite

Auth+DB+Stor

Functions

Serverless

Realtime

Subscriptions

Razorpay

Payments

FCM

Push Only

Data Layer

Backend

UI/Flutter

Riverpod State

Data/Drift

Backend

Figure 3.1 — FitKarma Four-Layer Architecture

3.2 Architecture Layers

Layer

Technology

Responsibility

UI / Presentation

Flutter 3.x Widgets

State Management

Riverpod 2.x Providers

Rendering

screens,

handling

gestures,

navigation

Business

logic,  async  state,  dependency

injection

Data / Repository

Drift DAO + Appwrite SDK

Local reads/writes, cloud sync, cache

Backend

Appwrite (self-hosted / cloud)

Auth, DB, File storage, Functions, Realtime

Security

SQLCipher

+  HKDF

+

Biometrics

Encryption at rest, auth, key derivation

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 77

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

3.3 Offline-First Data Flow

User Action ﬁ Drift (instant write) ﬁ UI Update (optimistic)
                    ﬂ
            SyncEngine (background)
                    ﬂ  idempotency key + version vector
            Appwrite API
                    ﬂ
            Conflict Resolution ﬁ merge / last-write-wins / user-prompt
                    ﬂ
            Drift update (if server wins)

3.4 Key Architectural Decisions

n Single Backend — Appwrite

Replaces Firebase Auth, Firestore, Storage, Functions, and Realtime in a single SDK. Reduces complexity and

vendor lock-in.

n Drift (SQLCipher) over Hive/Isar

Type-safe  SQL  with  full  query  power,  foreign  keys,  transactions.  SQLCipher  adds  AES-256  encryption

transparently.

n Riverpod over BLoC

Less  boilerplate  than  BLoC/Cubit.  Auto-dispose  scoping,  family  providers,  and  code-gen  fit  Flutter  3.x

ergonomics.

n HKDF per data class
Master key ﬁ derive per-class keys for medical, reproductive, journal data. Compromise of one class does not
expose others.

n Idempotency keys on all writes

UUID v4 per mutation. Retried ops never duplicate server-side records. Dead-Letter Queue handles persistent

failures.

n Offline map tiles

Bundled tile cache for India. Workout route maps work without connectivity.

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 78

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Complete Module Tree

§ 4
Folder Structure

4.1 Root Structure

fitkarma/
nnn lib/
n   nnn core/                      # Shared infrastructure
n   n   nnn config/                # device_tier.dart, remote_config.dart
n   n   nnn constants/             # app_constants.dart, api_endpoints.dart
n   n   nnn extensions/            # dart_extensions.dart
n   n   nnn router/                # app_router.dart (GoRouter)
n   n   nnn services/              # sync_engine.dart, encryption_service.dart
n   n   nnn utils/                 # date_utils.dart, validators.dart
n   nnn features/                  # Feature modules (35+)
n   n   nnn auth/                  # Authentication & Onboarding
n   n   nnn dashboard/             # Main dashboard + Karma engine
n   n   nnn nutrition/             # Food logging, AI scanner, recipes
n   n   nnn workout/               # Workout plans, video, custom
n   n   nnn steps/                 # Pedometer, routes, challenges
n   n   nnn sleep/                 # Sleep tracking, analysis
n   n   nnn water/                 # Hydration tracking
n   n   nnn health/                # BP, glucose, SpO2, ECG
n   n   nnn lab_reports/           # OCR, ABHA, doctor share
n   n   nnn mental_health/         # Mood, journal, PHQ-9, GAD-7
n   n   nnn ayurveda/              # Dosha, herbs, remedies
n   n   nnn medication/            # Reminders, adherence
n   n   nnn wearables/             # Fitbit, Garmin, Apple Health
n   n   nnn period_tracker/        # Cycle, symptoms, predictions
n   n   nnn pregnancy/             # Week tracking, nutrition
n   n   nnn social/                # Feed, challenges, leaderboard
n   n   nnn family/                # Members, emergency contacts
n   n   nnn festival/              # Calendar, fasting, events
n   n   nnn wedding/               # Planner, diet, workout
n   n   nnn settings/              # Profile, preferences, privacy
n   n   nnn subscription/          # Razorpay, plans, karma economy
n   n   nnn widgets_home/          # Android/iOS home screen widgets
n   nnn data/
n   n   nnn local/                 # Drift database, DAOs, tables
n   n   nnn remote/                # Appwrite repositories
n   n   nnn models/                # Shared data models
n   nnn main.dart
nnn assets/
n   nnn fonts/                     # Plus Jakarta Sans, JetBrains Mono
n   nnn animations/                # Lottie JSON files
n   nnn rive/                      # Rive animation files
n   nnn food_db/                   # Bundled Indian food database JSON
n   nnn map_tiles/                 # Offline India map tiles
nnn test/                          # Unit, widget, integration tests
nnn .github/workflows/             # CI/CD pipelines

4.2 Feature Module Structure

Every feature module follows a consistent internal structure:

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 79

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

features/nutrition/
nnn data/
n   nnn nutrition_repository.dart      # Interface
n   nnn nutrition_local_source.dart    # Drift DAO wrapper
n   nnn nutrition_remote_source.dart   # Appwrite collection wrapper
nnn domain/
n   nnn models/
n   n   nnn food_item.dart
n   n   nnn meal_log.dart
n   n   nnn nutrition_goals.dart
n   nnn nutrition_service.dart         # Business logic
nnn presentation/
n   nnn providers/
n   n   nnn food_log_provider.dart
n   n   nnn nutrition_goals_provider.dart
n   nnn screens/
n   n   nnn food_log_screen.dart
n   n   nnn food_search_screen.dart
n   n   nnn meal_plan_screen.dart
n   nnn widgets/
n       nnn macro_ring_widget.dart
n       nnn food_card_widget.dart
n       nnn meal_section_widget.dart
nnn nutrition_module.dart               # Module entry point

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 80

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 5
Appwrite Setup

Collections · Indexes · Functions

5.1 Appwrite Project Configuration

// .env.prod
APPWRITE_ENDPOINT=https://cloud.appwrite.io/v1
APPWRITE_PROJECT_ID=fitkarma_prod
APPWRITE_DATABASE_ID=fitkarma_db
APPWRITE_STORAGE_BUCKET_ID=fitkarma_media

// Appwrite SDK Init (lib/core/config/appwrite_config.dart)
final client = Client()
  ..setEndpoint(AppConfig.endpoint)
  ..setProject(AppConfig.projectId)
  ..setSelfSigned(status: false);

final account   = Account(client);
final databases = Databases(client);
final storage   = Storage(client);
final functions = Functions(client);
final realtime  = Realtime(client);

5.2 Authentication Methods

Method

Provider

Notes

Phone OTP

Appwrite SMS

Primary auth — Indian mobile numbers

Google OAuth

Google

Secondary option for urban users

Email/Password

Appwrite

Fallback, required for web admin

Apple Sign-In

Apple

iOS mandatory for OAuth apps

Biometric

Local only

Locks sensitive screens post-login (flutter_biometrics)

ABHA Linking

NHA API

Links Ayushman Bharat Health Account post-login

5.3 Appwrite Functions

Function

Trigger

Purpose

calculateKarma

DB event: log create

Recalculate XP on new log entry

syncInsights

CRON: daily 04:00 IST

Generate AI insight rules from aggregated data

sendStreakNotif

CRON: 20:00 IST

Push notification for streak at risk

processLabOcr

HTTP POST

Server-side OCR fallback for complex reports

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 81

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Function

Trigger

Purpose

generateReport

HTTP GET

PDF health report for doctor sharing

razorpayWebhook

HTTP POST

Handle Razorpay subscription events

whatsappBot

HTTP POST

Parse  WhatsApp  messages

for

food/water

logging

abhaTokenRefresh

CRON: every 2h

Refresh ABHA OAuth tokens

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 82

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 6
Database Schema

6.1 Core Collections

All  collections  live  in  the  Appwrite  database.  Each  document  maps  to  an  Appwrite  collection.  Primary  key  is

always $id (Appwrite auto-generated UUID).

All Collections & Attributes

Collection: users

Attribute

user_id

name

phone

dob

gender

height_cm

weight_kg

activity_level

goal

abha_id

subscription_tier

karma_points

level

streak_days

language

created_at

Type

string

string

string

Notes

Appwrite account $id

Display name

E.164 format — primary identifier

datetime

Date of birth

enum

male/female/other/prefer_not

float

float

enum

enum

string?

enum

integer

integer

integer

string

Height in centimetres

Current weight

sedentary/light/moderate/active/very_active

lose/maintain/gain/muscle

14-digit ABHA number, nullable

free/pro/lifetime

Total accumulated XP

Derived from karma_points

Current consecutive active days

BCP-47 language code

datetime

Account creation timestamp

Collection: food_logs

Attribute

user_id

Type

string

Notes

FK ﬁ users

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 83

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Attribute

food_item_id

meal_type

quantity_g

logged_at

calories_kcal

protein_g

carbs_g

fat_g

fibre_g

Type

string

enum

float

Notes

FK ﬁ food_items

breakfast/lunch/dinner/snack

Grams consumed

datetime

Meal timestamp

Calculated from quantity

float

float

float

float

float

is_synced

boolean

Drift sync flag

Collection: workout_sessions

Attribute

user_id

plan_id

started_at

ended_at

Type

string

string?

Notes

FK ﬁ users

FK ﬁ workout_plans (nullable if custom)

datetime

Session start

datetime?

Session end

duration_min

integer

Total duration

calories_burned

exercises

notes

float

string

Estimated from MET + weight

JSON array of exercise logs

string?

Optional session notes

Collection: step_logs

Attribute

user_id

date

steps

Type

string

string

Notes

FK ﬁ users

YYYY-MM-DD

integer

Total steps for day

distance_km

float

GPS or stride estimate

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 84

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Attribute

calories

Type

float

Notes

Steps-based estimate

active_minutes

integer

Minutes above threshold

source

enum

phone/fitbit/garmin/apple_health

Collection: sleep_logs

Attribute

user_id

date

sleep_start

sleep_end

duration_min

deep_min

rem_min

light_min

awake_min

score

source

Type

string

string

datetime

datetime

integer

integer

integer

integer

integer

integer

enum

Notes

FK ﬁ users

YYYY-MM-DD night of

Total sleep time

Deep sleep minutes

REM minutes

Light sleep minutes

0–100 quality score

phone/wearable/manual

6.2 Health Collections

Collection: bp_logs

Attribute

systolic

diastolic

pulse

arm

posture

notes

Type

integer

integer

integer

enum

enum

string?

Description

mmHg

mmHg

bpm

left/right

sitting/standing/lying

Collection: glucose_logs

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 85

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Attribute

value_mg_dl

measure_type

hba1c_pct

notes

Collection: spo2_logs

Attribute

spo2_pct

pulse

notes

Collection: mood_logs

Attribute

score

emotions

journal_text_enc

iv

Collection: period_logs

Type

float

enum

float?

string?

Type

float

integer

string?

Type

integer

string

string

string

Description

Fasting or post-meal

fasting/post_meal/random/hba1c

Only for HbA1c type

Description

Oxygen saturation %

bpm

Description

1–5 scale

JSON array of emotion tags

AES-256-GCM encrypted journal entry

HKDF-derived IV

Attribute

cycle_start

cycle_end

flow

symptoms

notes_enc

Type

Description

datetime

Start of period

datetime?

End of period

enum

string

string

light/medium/heavy/spotting

JSON array

Encrypted

Collection: medication_logs

Attribute

medication_id

Type

string

Description

FK ﬁ medications

taken_at

datetime

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 86

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Attribute

skipped

notes

Type

Description

boolean

string?

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 87

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 7
Local Storage — Drift (SQLite)

Tables · DAOs · Encryption

7.1 Drift Database Setup

// lib/data/local/app_database.dart
@DriftDatabase(tables: [
  FoodLogTable, WorkoutTable, StepLogTable, SleepLogTable,
  WaterLogTable, BpLogTable, GlucoseLogTable, SpO2LogTable,
  MoodLogTable, PeriodLogTable, MedicationLogTable,
  SyncQueueTable, DeadLetterQueueTable,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override int get schemaVersion => 7;

  @override MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      // Run schema migrations
    },
  );
}

// SQLCipher setup — encrypted database
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'fitkarma.db'));
    final key = await EncryptionService.getDatabaseKey();  // HKDF-derived
    return NativeDatabase.createInBackground(file,
      logStatements: kDebugMode,
      setup: (rawDb) {
        rawDb.execute("PRAGMA key = '$key'");          // SQLCipher unlock
        rawDb.execute("PRAGMA cipher_page_size = 4096");
        rawDb.execute("PRAGMA kdf_iter = 64000");
      },
    );
  });
}

7.2 Key Tables

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 88

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

// lib/data/local/tables/food_log_table.dart
class FoodLogTable extends Table {
  IntColumn get id      => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get foodId => text()();
  RealColumn get qty    => real()();
  TextColumn get meal   => text()();  // breakfast/lunch/dinner/snack
  DateTimeColumn get loggedAt => dateTime()();
  RealColumn get kcal   => real()();
  RealColumn get protein => real()();
  RealColumn get carbs  => real()();
  RealColumn get fat    => real()();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();
  TextColumn get syncId => text().nullable()();  // idempotency key
}

// lib/data/local/tables/sync_queue_table.dart
class SyncQueueTable extends Table {
  TextColumn get id          => text().withLength(min:36, max:36)();  // UUID v4
  TextColumn get operation   => text()();  // create / update / delete
  TextColumn get collection  => text()();  // Appwrite collection name
  TextColumn get documentId  => text()();
  TextColumn get payload     => text()();  // JSON
  IntColumn  get retryCount  => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get nextRetry => dateTime()();
}

7.3 DAO Pattern

// lib/data/local/daos/food_log_dao.dart
@DriftAccessor(tables: [FoodLogTable])
class FoodLogDao extends DatabaseAccessor<AppDatabase>
    with _$FoodLogDaoMixin {
  FoodLogDao(AppDatabase db) : super(db);

  // Reactive stream — UI auto-updates on any write
  Stream<List<FoodLogEntry>> watchTodayLogs(String userId) {
    final today = DateTime.now();
    return (select(foodLogTable)
      ..where((t) => t.userId.equals(userId) &
                     t.loggedAt.isBetweenValues(
                       DateTime(today.year, today.month, today.day),
                       DateTime(today.year, today.month, today.day, 23, 59),
                     ))
      ..orderBy([(t) => OrderingTerm.asc(t.loggedAt)]))
      .watch();
  }

  Future<int> insertLog(FoodLogTableCompanion log) =>
      into(foodLogTable).insert(log);

  Future<bool> updateLog(FoodLogTableCompanion log) =>
      update(foodLogTable).replace(log);

  Future<int> deleteLog(int id) =>
      (delete(foodLogTable)..where((t) => t.id.equals(id))).go();
}

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 89

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 8
Offline Sync Architecture

Idempotency · DLQ · Version Vectors

8.1 Sync Engine Overview

Every  write  operation  in  FitKarma  is  first  committed  to  Drift  (local),  then  queued  for  Appwrite  sync.  The  sync

engine runs as a background isolate and processes the queue when connectivity is available.

// lib/core/services/sync_engine.dart — high level
class SyncEngine {
  final AppDatabase _db;
  final Databases _appwrite;
  final ConnectivityService _connectivity;

  Future<void> processQueue() async {
    if (!await _connectivity.isOnline) return;

    final pending = await _db.syncQueueDao.getPendingItems(limit: 50);
    for (final item in pending) {
      try {
        await _executeSync(item);
        await _db.syncQueueDao.markSynced(item.id);
      } on AppwriteException catch (e) {
        if (e.code == 409) {
          // Conflict — resolve and retry
          await _resolveConflict(item);
        } else if (item.retryCount >= 5) {
          // Move to Dead Letter Queue
          await _db.dlqDao.insert(item.toDeadLetter(error: e.message));
          await _db.syncQueueDao.delete(item.id);
        } else {
          await _db.syncQueueDao.incrementRetry(item.id,
            nextRetry: DateTime.now().add(Duration(minutes: pow(2, item.retryCount).toInt())));
        }
      }
    }
  }
}

8.2 Idempotency Keys

Every  mutation  includes  a  UUID  v4  idempotency  key.  If  the  same  operation  is  retried  after  a  network  failure,

Appwrite rejects the duplicate without creating a new document.

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 90

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

// Idempotency key flow
final syncId = Uuid().v4();  // generated once per user action

// Written to Drift immediately
await db.foodLogDao.insertLog(log.copyWith(syncId: syncId));

// Queue entry includes the same key
await db.syncQueueDao.enqueue(SyncItem(
  id: syncId,              // ‹ same key used as Appwrite document ID
  operation: 'create',
  collection: 'food_logs',
  payload: jsonEncode(log.toJson()),
));

8.3 Version Vectors (Per-Field)

// Each synced document carries a version vector
// { "weight_kg": 12, "goal": 7, "height_cm": 3 }
// Field-level merge: take higher version per field
// Avoids full-document last-write-wins data loss

class VersionVector {
  final Map<String, int> _vector;

  VersionVector merge(VersionVector remote) {
    final merged = Map<String, int>.from(_vector);
    remote._vector.forEach((field, remoteVer) {
      merged[field] = max(merged[field] ?? 0, remoteVer);
    });
    return VersionVector(merged);
  }
}

8.4 Dead Letter Queue

Items  that  fail  after  5  retries  are  moved  to  the  Dead  Letter  Queue  (DLQ).  Users  see  a  non-blocking  amber
banner when DLQ contains items. They can review and retry or discard them from Settings ﬁ Data & Sync.

// Dead Letter Queue table
class DeadLetterQueueTable extends Table {
  TextColumn get id          => text()();   // original sync ID
  TextColumn get collection  => text()();
  TextColumn get payload     => text()();
  TextColumn get errorMsg    => text()();
  DateTimeColumn get failedAt => dateTime()();
}

// Warning banner trigger (in DashboardScreen)
ref.watch(dlqCountProvider).when(
  data: (count) => count > 0
    ? DlqWarningBanner(count: count)   // amber glass banner
    : const SizedBox.shrink(),
  ...
);

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 91

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 9
Authentication & Onboarding

Phone OTP · Google · ABHA · Biometrics

9.1 Authentication Flow

// Primary flow: Phone OTP
1. User enters +91 phone number
2. Appwrite sends SMS OTP (6 digits, 5 min TTL)
3. User enters OTP ﬁ Appwrite session created
4. Check if user document exists in 'users' collection
5a. New user ﬁ Navigate to Onboarding flow (5 screens)
5b. Existing user ﬁ Navigate to Dashboard

// Onboarding screens (new users only)
Screen 1: Name + Gender
Screen 2: Date of birth + Height/Weight
Screen 3: Activity level + Health goals
Screen 4: Language preference (22 options)
Screen 5: ABHA linking (optional, skippable)
         ﬁ If linked: fetch health records consent
         ﬁ Biometric lock setup (optional)

9.2 Biometric Lock

Sensitive  screens  (journal  entries,  period  tracker,  blood  pressure  logs)  require  biometric  re-authentication  if

biometricLock is enabled in user preferences.

// Biometric check on sensitive screen navigation
class BiometricGuard extends ConsumerWidget {
  const BiometricGuard({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(biometricLockEnabledProvider).when(
      data: (enabled) => enabled
        ? FutureBuilder(
            future: LocalAuthentication().authenticate(
              localizedReason: 'Unlock health data',
              options: const AuthenticationOptions(biometricOnly: false),
            ),
            builder: (ctx, snap) =>
              snap.data == true ? child : const LockScreen(),
          )
        : child,
      ...
    );
  }
}

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 92

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Nutrition · Workout · Steps · Sleep · Water

§ 10
Core Feature Modules

10.1 Nutrition Module

Food  logging  with  5M+  item  Indian  food  database,  AI  camera  scanner,  meal  planning,  macro  tracking,  and

Ayurveda nutrition insights.

Feature

Search

AI Scanner

Quick Log

Meal Plan

Description

5M+ Indian food DB (bundled JSON + Appwrite search)

On-device camera ﬁ GPT-4o Vision via Appwrite Function

Voice input, barcode scan, recent/favourite shortcuts

7-day AI-generated plans, festival-aware, dosha-aligned

Macro Rings

Animated donut chart: carbs/protein/fat/fibre

Calorie Budget

Dynamic goal based on TDEE + activity level

Zomato/Swiggy

Restaurant menu calorie lookup via cached data

Export

PDF nutrition report shareable with dietitian

10.2 Workout Module

Structured workout plans, video guidance, custom routine builder, exercise library, and wearable-aware calorie

calculation.

Feature

Library

Plans

Video

Custom

Description

500+ exercises with form cues, muscle groups, equipment

Beginner/intermediate/advanced, Indian home workouts

Hosted on Appwrite Storage, streamed in-app

Drag-and-drop routine builder, set/rep/rest configuration

Live Timer

Built-in rest timer with haptic + audio cues

Calorie Burn

MET-based calculation using user weight + duration

Progress

Personal records, volume charts, muscle group heatmap

10.3 Step Counter Module

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 93

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Persistent  pedometer  using  phone  accelerometer,  GPS  route  tracking,  step  challenges,  and  wearable  data

merge.

Feature

Description

Pedometer

Workmanager background isolate, fused with wearable data

Goal

Routes

Dynamic daily goal (10K default, adaptive)

GPS route map with offline tile cache

Weekly Chart

7-day bar chart with streak indicators

Challenges

Community 30-day challenges, leaderboards

Achievements

Badges: 1K, 5K, 10K, marathon, steps in rain

10.4 Sleep Tracker Module

Automated  sleep  detection  via  accelerometer  +  microphone,  sleep  stage  analysis,  quality  scoring,  and  AI

bedtime coaching.

Feature

Detection

Stages

Score

Description

Accelerometer movement + snore detection ﬁ stage estimation

Awake / REM / Light / Deep breakdown

0–100 quality score with trend

Smart Alarm

Wakes during light sleep phase ±30 min of target

Insights

Correlation with mood, exercise, food patterns

Bedtime Coach

Push notification 45 min before recommended bedtime

10.5 Water Intake Module

Hydration tracking with climate-aware goals, quick-add buttons, reminder system, and weather API integration.

Feature

Quick Add

Goal

Description

Glass (200ml), bottle (500ml), custom amount

Dynamic: base 2.5L + 250ml per workout + 200ml per heat notch

Reminders

Smart notifications every 2h (skips sleep window)

Widget

Home screen widget with live progress bar

Source Track

Tap water, filtered, coconut water, buttermilk

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 94

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 11
Advanced Feature Modules

AI · Ayurveda · Recipe Engine · WhatsApp Bot

11.1 AI Nutrition Scanner
On-device camera or gallery photo ﬁ cloud AI identifies food, estimates portion size, and logs macros. Works
via Appwrite Function calling GPT-4o Vision.

Feature

Detection

Portion

Description

GPT-4o Vision via Appwrite Function (no API key in app)

Plate size calibration, reference objects for scale

Confidence

Shows confidence %, allows manual override

Offline fallback

Local ML model (TFLite) for 200 common Indian foods

Barcode

flutter_barcode_scanner for packaged foods

11.2 Ayurveda Engine

Dosha analysis, Ayurvedic food classification, herb recommendations, and seasonal Ritucharya routines — all

offline.

Feature

Description

Dosha Quiz

25-question assessment ﬁ Vata/Pitta/Kapha profile

Food DB

Herbs

Each food tagged with dosha effects (increases/decreases/neutral)

400+ herbs with evidence level, preparation, contraindications

Ritucharya

Seasonal routine recommendations (6 Ritu)

Daily Dincharya

Personalized morning/evening routine

Nutrition overlay

Dosha tags shown on food log and meal plan screens

11.3 Recipe Engine

1,000+  Indian  recipes  with  nutritional  breakdown,  meal  plan  integration,  ingredient  scaling,  and  dosha

alignment.

Feature

Database

Filters

Description

1,000+ Indian recipes (bundled), 5,000+ via Appwrite

Vegetarian/vegan/jain/keto/diabetic-friendly/dosha

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 95

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Feature

Scaling

Nutrition

Description

Auto-scale ingredients for household size

Full macro/micro breakdown per serving

Meal plan

One-tap add to meal plan from recipe view

Shopping list

Auto-generate ingredient list for week plan

11.4 WhatsApp Bot Integration

Log food and water via WhatsApp messages. Users can text 'had dal rice for lunch' and the bot parses and logs

it.

Feature

NLP

Description

Appwrite Function + Claude API for intent parsing

Commands

Log food, log water, check steps, get summary

Language

Supports Hindi and English messages

Privacy

Setup

No message storage — processed and discarded

OTP verification links WhatsApp number to account

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 96

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 12
Health Monitoring Modules

BP · Glucose · SpO2 · ECG · Lab OCR

FitKarma's health monitoring suite covers chronic disease management, vital sign tracking, and clinical-grade

lab report parsing. All data is stored encrypted locally and synced to Appwrite with user consent.

12.1 Blood Pressure Tracker

Feature

Manual log

Description

Systolic/diastolic/pulse, arm, posture

Classification

AHA 2023 categories with colour-coded status

Trends

30-day chart, moving average, min/max

Medication correlation

Overlay BP-lowering medication adherence

Doctor report

PDF summary shareable via Appwrite Storage link

Emergency

Crisis reading (>180/120) triggers emergency alert

12.2 Blood Glucose Tracker

Feature

Types

Targets

Chart

Description

Fasting, post-meal, random, HbA1c

Customisable target ranges (diabetes/pre-diabetes/normal)

Scatter plot with meal markers

HbA1c estimator

Approximates 3-month average from daily readings

Insulin log

Optional insulin dose recording

12.3 SpO2 / Oxygen Saturation

Feature

Source

Alerts

Description

Wearable (Fitbit/Garmin) or manual

SpO2 < 95% triggers notification

Night view

Overnight SpO2 dip chart from wearable data

12.4 Lab Report OCR

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 97

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Feature

On-device

Parser

Description

ML Kit OCR processes report image offline

Pattern matching extracts 50+ standard lab values

ABHA sync

Results stored in ABHA personal health record

Trend

Compare same test across multiple reports

Doctor share

Encrypted link with expiry for doctor

12.5 Medication Tracker

Feature

Schedule

Reminders

Adherence

Interaction

Refill

Description

One-time, daily, weekly, custom intervals

Push notification with snooze

Streaks, adherence %, missed dose log

Basic drug interaction warnings (offline DB)

Pill count, refill reminder

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 98

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 13
Lifestyle & Wellness Modules

Mental Health · Period · Ayurveda · Meditation

13.1 Mental Health & Mood

Feature

Mood log

Journal

PHQ-9

GAD-7

Description

5-level emoji scale + 20 emotion tags

Rich text, encrypted at rest with HKDF key

Depression screening, scored, trended over time

Anxiety screening

Stress level

0–10 manual + correlation with sleep/steps

Mindfulness

Guided breathing, body scan, gratitude prompt

Crisis resource

Igateway to iCall, Vandrevala Foundation when PHQ-9 ‡ 15

13.2 Period & Reproductive Health

Feature

Cycle log

Prediction

Symptoms

Description

Start/end date, flow intensity, symptoms

ML period + ovulation prediction (on-device)

60+ symptom tags (PMS, cramps, mood, energy)

Fertility window

Ovulation window highlighting

Insights

Privacy

Export

Cycle length trends, irregularity alerts

All data AES-256-GCM encrypted with HKDF rose-class key

PDF cycle report for gynaecologist

13.3 Meditation & Mindfulness

Feature

Sessions

Timer

Breathing

Description

50+ guided meditations (bundled audio, just_audio)

Configurable timer with ambient sounds

Box, 4-7-8, Pranayama (Anulom Vilom, Kapalbhati)

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 99

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Feature

Streak

Description

Daily meditation streak with XP reward

Integration

Meditation logs affect mood score positively

13.4 Festival & Wedding Planner

Feature

Calendar

Description

Hindu festival calendar (200+ events), fasting days

Fasting plan

Navratri, Karva Chauth, Ekadashi nutrition adapters

Wedding

Reminders

12-week fitness + diet plan for bride/groom

Festival-aware workout adaptations (light yoga during fast)

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 100

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 14
Social & Community Modules

Feed · Challenges · Leaderboards · Groups

14.1 Social Feed

A privacy-first activity feed. Users control visibility per activity type. No personal health data is posted without

explicit opt-in.

// Feed visibility settings (per user, per activity type)
enum FeedVisibility { public, friendsOnly, private }

class FeedSettings {
  FeedVisibility steps;          // default: friendsOnly
  FeedVisibility workouts;       // default: friendsOnly
  FeedVisibility achievements;   // default: public
  FeedVisibility challenges;     // default: public
  FeedVisibility healthData;     // default: private (always — never auto-posted)
}

14.2 Community Challenges

Feature

Types

Duration

Join

Progress

Rewards

Festive

Description

Steps, calorie burn, workout frequency, hydration, sleep score

Daily, weekly, 30-day, custom

Public join or invite-only (code)

Real-time leaderboard, progress bar, rank badge

XP multiplier + exclusive Karma badge on completion

Navratri Dance Steps challenge, IPL Walking challenge

14.3 Leaderboards

Feature

Scope

Metric

Update

Privacy

Description

Global, city-based, friends-only, group

Steps, active minutes, streak, Karma points

Real-time via Appwrite Realtime subscription

Leaderboard uses display name, never full name

Anonymous

Option to appear as 'Anonymous Warrior'

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 101

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

14.4 Workout Partner

Feature

Match

Description

Match by city, fitness level, language, goal

Accountability

Shared streak tracker, nudge notifications

Chat

Safety

Text chat via Appwrite Database (no third-party chat SDK)

Block/report feature, moderation queue

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 102

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Notifications · Widgets · Connectivity

§ 15
Platform & Infrastructure

15.1 Push Notifications

Feature

Provider

Delivery

Types

Smart

Description

FCM token via firebase_messaging — no Firebase DB

Token stored in Appwrite users collection

Streak at-risk, reminder, challenge update, insight, refill

Skips notifications during sleep window (22:00–07:00 IST default)

Low data

FCM payload-only (no images) when Low Data Mode enabled

15.2 Home Screen Widgets

Feature

Android

iOS

Sizes

Update

Description

Glance API via home_widget package

WidgetKit via home_widget package

2×2 (stats ring), 2×1 (Karma), 1×1 (streak)

Triggered after each sync cycle, max 15-min refresh

Dark/Light

Respects system theme, orange/teal brand colours

15.3 Connectivity Management

Feature

Detection

Description

connectivity_plus package

Low Data Mode

Toggle in Settings ﬁ Data & Sync

Adaptations

No blur, no images, text-only feed, no video

Banner

Persistent teal pill 'Low Data Mode'

2G support

All core functions work on 2G via local Drift reads

15.4 Remote Config

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 103

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Feature

Storage

Fields

Fetch

Offline

No SDK

Description

Appwrite 'remote_config' collection

Feature flags, insight rules, A/B variants, announcement

On app foreground, max 30-min cache

Last-fetched config persisted in Drift

Custom implementation — no Firebase RC dependency

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 104

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 16
Security & Privacy

AES-256-GCM · HKDF · Biometrics · GDPR

16.1 Encryption Architecture

FitKarma  uses  a  multi-layer  encryption  model.  The  master  key  lives  in  the  device  secure  enclave

(flutter_secure_storage). Per-class keys are derived using HKDF, so compromise of one class does not expose

others.

// Key hierarchy
Master Key (device secure enclave)
    n
    nnn HKDF("database") ﬁ SQLCipher database key
    nnn HKDF("medical")  ﬁ BP, Glucose, SpO2, Medication data
    nnn HKDF("reproductive") ﬁ Period, Pregnancy data
    nnn HKDF("journal")  ﬁ Mental health journal entries
    nnn HKDF("sync")     ﬁ Encrypted sync payload keys

// HKDF derivation (lib/core/services/encryption_service.dart)
Uint8List deriveKey(String context) {
  final masterKey = secureStorage.read(key: 'master_key');
  return Hkdf(
    hmac: Hmac.sha256(),
    outputLength: 32,
  ).deriveKey(
    secretKey: SecretKey(masterKey),
    info: utf8.encode(context),
  );
}

// AES-256-GCM encryption
Future<EncryptedData> encrypt(Uint8List plaintext, String keyClass) async {
  final key = await deriveKey(keyClass);
  final iv = SecretKey(Fortuna().nextBytes(12));  // 96-bit IV
  final secretBox = await AesCtr.with256bits(
    macAlgorithm: Hmac.sha256(),
  ).encryptSync(plaintext, secretKey: SecretKey(key), nonce: iv.extractBytes());
  return EncryptedData(ciphertext: secretBox.cipherText, iv: iv.extractBytes(), mac: secretBox.mac.bytes);
}

Data Class

Food logs

Encryption

Storage

Sync

None (low sensitivity)

Drift plain

Appwrite DB

Step counts

None

Drift plain

Appwrite DB

BP / Glucose

AES-256-GCM (medical)

Drift encrypted field

Encrypted payload

Journal entries

AES-256-GCM (journal)

Drift encrypted field

Encrypted payload

Period data

AES-256-GCM

(reproductive)

Drift encrypted field

Encrypted payload

Mental health

AES-256-GCM (journal)

Drift encrypted field

Encrypted payload

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 105

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Data Class

Encryption

Storage

Sync

ABHA token

flutter_secure_storage

Keychain/Keystore

Never synced

16.2 Privacy Principles

(cid:127) No advertising SDKs — ever. No Firebase Analytics, AdMob, or third-party tracking.

(cid:127) No data sold to third parties. User data is used only to provide the service.

(cid:127) Data portability: Users can export all their data as JSON from Settings ﬁ Data & Sync.

(cid:127) Right to erasure: Users can delete all data and account from Settings ﬁ Privacy ﬁ Delete Data.

(cid:127) Minimal data collection: Only data required for features is collected.

(cid:127) ABHA consent: Each health record access from ABHA requires explicit user consent per request.

(cid:127) biometricLock: Sensitive screens re-authenticate with fingerprint/Face ID on each entry.

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 106

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 17
External API Integrations

Fitbit · Razorpay · ABHA · NHA

Integration

Auth

Data Retrieved

Offline Behaviour

Fitbit API

OAuth 2.0 PKCE

Steps, HR, sleep, SpO2

Garmin Connect

OAuth 1.0a

Steps, HR, GPS routes

Apple HealthKit

iOS permission

All HealthKit metrics

Google Fit

OAuth 2.0

Steps, HR, weight

Last-synced  data  from

Drift

Last-synced  data  from

Drift

CoreData  bridge  —

always local

Last-synced  data  from

Drift

Razorpay

API

Key

(backend)

Subscription status

Cached tier in Drift

ABHA / NHA

OAuth + OTP

Health records, lab results

Zomato (cached)

No API — cached

DB

Restaurant menu calories

Cached

consent

in

Drift

Full  offline  —  bundled

DB

FCM (push only)

Firebase SA

Delivery tokens only

No functionality impact

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 107

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 18
Performance Contracts

SLAs · Benchmarks · Battery · App Size

Metric

Target

Measurement Method

APK size (arm64-v8a)

< 50 MB

CI/CD  build  size  check  —

fails  build

if

exceeded

Cold start (P95)

< 2 seconds

Firebase Performance / manual stopwatch

Dashboard render (P95)

< 1 second

Flutter DevTools frame timing

Food search latency

< 300 ms

Drift FTS5 full-text search benchmark

Sync cycle (50 items)

< 5 seconds

Integration test with mock Appwrite

Background step tracking

< 3% battery/hr

Android Battery Historian

Blur frame rate (mid-tier)

> 58 fps

Flutter DevTools (no janky frames)

Offline availability

100% core features

Airplane mode integration test

Encryption overhead

< 5 ms per field

Dart benchmark harness

18.1 App Size Enforcement

# CI/CD size check (.github/workflows/ci.yml)
- run: |
    SIZE=$(du -sm build/app/outputs/flutter-apk/app-arm64-v8a-release.apk | cut -f1)
    echo "APK size: ${SIZE} MB"
    if [ $SIZE -gt 50 ]; then echo "ERROR: APK exceeds 50 MB" && exit 1; fi

18.2 Performance Budget — UI

Render Context

Frame Budget

Technique

Dashboard (cold)

1s total

Optimistic Drift reads, no skeleton loaders

60 fps scroll

16.67 ms/frame

const constructors, RepaintBoundary on cards

Glassmorphism blur

Max  12px  blur

radius

Tier-gate: disabled on low, reduced on mid

Image loading

< 200 ms

CachedNetworkImage + Drift-cached URLs

Chart render (1yr data)

< 300 ms

fl_chart decimation, off-main-thread calc

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 108

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 19
State Management

Riverpod 2.x Patterns · Providers · Code-Gen

19.1 Provider Types Used

Provider Type

Use Case

Example

Provider

Static singleton services

appwriteClientProvider, databaseProvider

StateProvider

Simple UI state

selectedMealTypeProvider, isLoadingProvider

FutureProvider

One-shot async data

userProfileProvider, subscriptionProvider

StreamProvider

Reactive DB streams

todayFoodLogsProvider (Drift .watch())

AsyncNotifierProvider

Complex async actions

FoodLogNotifier (log, update, delete)

NotifierProvider

Sync state with actions

ThemeNotifier, KarmaNotifier

FamilyProvider

Parameterised providers

stepLogsForDateProvider(date)

19.2 Provider Example — Food Log

// lib/features/nutrition/presentation/providers/food_log_provider.dart
@riverpod
class FoodLogNotifier extends _$FoodLogNotifier {
  @override
  FutureOr<List<FoodLog>> build() {
    // Subscribe to Drift stream — auto-rebuilds on any DB change
    final userId = ref.watch(currentUserProvider).value?.id ?? '';
    return ref.watch(databaseProvider)
      .foodLogDao
      .watchTodayLogs(userId)
      .first;
  }

  Future<void> logFood(FoodLogCompanion entry) async {
    final db = ref.read(databaseProvider);
    final syncEngine = ref.read(syncEngineProvider);

    // 1. Write to Drift immediately (optimistic)
    final id = await db.foodLogDao.insertLog(entry);

    // 2. Queue for Appwrite sync
    await syncEngine.enqueue(
      operation: SyncOperation.create,
      collection: 'food_logs',
      payload: entry.toJson()..['$id'] = entry.syncId.value,
    );

    // 3. Award Karma XP
    ref.read(karmaNotifierProvider.notifier).awardXP(XPEvent.foodLogged);
  }
}

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 109

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 20
Monetization & Subscriptions

Razorpay · Plans · Karma Economy

20.1 Subscription Plans

Plan

Free

Price

n0

Billing

N/A

Pro Monthly

n99/month

Monthly auto-renew

Features

Core

tracking,  30-day  history,  basic

insights

All features, unlimited history, AI scanner,

wearables

Pro Yearly

n799/year

Annual auto-renew

All Pro features + 33% saving vs monthly

Lifetime

n1,999 one-time

One-time purchase

All  Pro  features  forever,  future  features

included

20.2 Karma Economy

Action

Log any meal

Log water

XP Awarded

Notes

+5 XP

+2 XP

Up to 3×/day

Up to 8×/day

Complete step goal

+20 XP

Daily

Workout session

+25 XP

Per session

7-day streak

30-day streak

Log blood pressure

Complete challenge

Lab report upload

Journal entry

Refer a friend

+100 XP

Bonus

+500 XP

Milestone

+10 XP

+200 XP

+30 XP

+8 XP

Daily

+150 XP

On first login

20.3 Karma Levels

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 110

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Level

Title

XP Required

1

2

3

4

5

6

7

8

9

10

Seedling

Sprout

Sapling

Warrior

Champion

Master

Guardian

Legend

Immortal

FitGuru

0

250

600

1200

2500

5000

10000

20000

50000

100000

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 111

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 21
Testing Strategy

Unit · Widget · Integration · Golden

21.1 Test Coverage Targets

Layer

Target Coverage

Framework

Domain / business logic

Drift DAOs

Riverpod providers

> 90%

> 85%

> 80%

dart test

dart test with in-memory DB

flutter_riverpod test helpers

Widget smoke tests

100% screens

flutter_test

Golden / screenshot

Critical screens

alchemist / golden_toolkit

Integration (E2E)

Core user flows

flutter integration_test

Sync engine

> 95%

Unit test with mock Appwrite

21.2 Unit Test Example

// test/features/nutrition/food_log_notifier_test.dart
void main() {
  late ProviderContainer container;
  late MockFoodLogDao mockDao;

  setUp(() {
    mockDao = MockFoodLogDao();
    container = ProviderContainer(overrides: [
      foodLogDaoProvider.overrideWithValue(mockDao),
      currentUserProvider.overrideWithValue(AsyncData(testUser)),
    ]);
  });

  test('logFood writes to Drift and queues sync', () async {
    // Arrange
    when(() => mockDao.insertLog(any())).thenAnswer((_) async => 1);
    final notifier = container.read(foodLogNotifierProvider.notifier);

    // Act
    await notifier.logFood(testFoodLogCompanion);

    // Assert
    verify(() => mockDao.insertLog(testFoodLogCompanion)).called(1);
    final queue = container.read(syncQueueProvider);
    expect(queue.length, 1);
    expect(queue.first.collection, 'food_logs');
  });
}

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 112

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Dart · Architecture · Naming Conventions

§ 22
Coding Standards

22.1 Naming Conventions

Element

Files

Classes

Variables

Constants

Providers

Convention

Example

snake_case

food_log_screen.dart

PascalCase

FoodLogNotifier

camelCase

totalCalories

camelCase const

defaultDailyStepGoal

camelCase  +  Provider

suffix

foodLogNotifierProvider

Riverpod gen

@riverpod annotation

@riverpod class FoodLogNotifier

Drift tables

DAOs

Enums

PascalCase  +  Table

suffix

FoodLogTable

PascalCase + Dao suffix

FoodLogDao

PascalCase values

enum MealType { breakfast, lunch }

22.2 Key Rules

(cid:127) Never hardcode hex values — always use AppTokens.primary etc.

(cid:127) All UI rebuilds must be driven by Riverpod watches — no setState in feature screens.

(cid:127) No direct Appwrite SDK calls in widgets — always go through repositories.

(cid:127) Encrypted fields must never be logged (print/debugPrint) in any build mode.

(cid:127) All async providers must handle loading, data, and error states explicitly.

(cid:127) const constructors on all stateless widgets — enforced by flutter_lints.

(cid:127) No platform-specific code in feature modules — use abstraction in core/.

(cid:127) All monetary amounts in paise (integer) — never floating-point for currency.

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 113

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 23
Environment Configuration

Secrets · .env · RemoteConfig

23.1 .env Files

# .env.prod — never committed, injected by CI/CD
APPWRITE_ENDPOINT=https://cloud.appwrite.io/v1
APPWRITE_PROJECT_ID=xxxx
APPWRITE_DATABASE_ID=yyyy
RAZORPAY_KEY_ID=rzp_live_xxxx
FITBIT_CLIENT_ID=zzzz
SENTRY_DSN=https://....@sentry.io/...

# .env.staging
APPWRITE_ENDPOINT=https://staging.appwrite.io/v1
APPWRITE_PROJECT_ID=staging_xxxx
RAZORPAY_KEY_ID=rzp_test_xxxx

23.2 RemoteConfig Flags

Flag

Type

Default

Purpose

aiScannerEnabled

boolean

glassBlurEnabled

boolean

true

true

Toggle AI food scanner globally

Override device-tier glass blur

whatsappBotEnabled

boolean

false

Gradual WhatsApp bot rollout

abhaEnabled

boolean

festivalMode

proMonthlyPrice

insightRules

string

integer

json

true

null

99

[]

Toggle ABHA integration

Active festival name (e.g. 'navratri')

Dynamic pricing in INR

Server-updated insight detection rules

maintenanceMode

boolean

false

Show maintenance banner

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 114

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

GitHub Actions · Backup · Admin Dashboard

§ 24
CI/CD Pipeline

24.1 Pipeline Overview

Stage

test

Trigger

Runner

Actions

All PRs + push

ubuntu-latest

flutter analyze, flutter test --coverage

check_app_size

After test

ubuntu-latest

Build APK, assert < 50 MB

build_android

main branch only

ubuntu-latest

flutter build appbundle

build_ios

main branch only

macos-latest

flutter build ipa (code-signed)

deploy_staging

develop branch

ubuntu-latest

appwrite deploy function --all

24.2 GitHub Secrets Required

APPWRITE_PROJECT_ID               — Production Appwrite project ID
APPWRITE_DATABASE_ID              — Production database ID
APPWRITE_STAGING_PROJECT_ID       — Staging project ID
APPWRITE_STAGING_ENDPOINT         — Staging endpoint URL
RAZORPAY_KEY_ID                   — Live Razorpay key
FITBIT_CLIENT_ID                  — Fitbit app client ID
IOS_DIST_CERT_P12                 — iOS distribution certificate
IOS_DIST_CERT_PASSWORD            — Certificate password
APPSTORE_ISSUER_ID                — App Store Connect issuer
APPSTORE_KEY_ID                   — App Store Connect key ID
APPSTORE_PRIVATE_KEY              — App Store Connect private key

24.3 Disaster Recovery

# Daily backup cron — 02:00 IST
0 20 * * * appwrite databases export \
  --databaseId $DATABASE_ID \
  --output /backups/fitkarma-$(date +%Y%m%d).json \
  && rclone copy /backups/ b2:fitkarma-backups/

# Retention: 30 daily backups; 12 monthly backups
# Storage: Backblaze B2
# Recovery test: Monthly restore drill in staging

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 115

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ UI
App Demo — Screen Gallery

45+ Annotated Mockups

The  following  pages  present  rendered  UI  mockups  for  all  major  FitKarma  screens.  Each  mockup  faithfully

represents the design tokens, layout patterns, glassmorphism surfaces, and component hierarchy described in

the UI Design System. Dark mode is shown unless otherwise noted.

Onboarding & Authentication Screens

FK

FitKarma

India's Fitness Platform

Offline-First · Privacy-Centric

n

Your Fitness Journey
India's most affordable
health companion

Get Started  ﬁ

Sign In

Figure UI-1 · Splash screen with spring-animated logo reveal (Rive) and onboarding welcome with progress dots

Splash / Logo Screen

Welcome Onboarding (Slide 1)

Main Dashboard & Karma

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 116

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

FitKarma
Namaste, Rahul n

R

1,247

Karma Points  (cid:127)  Level 8

Today's Activity

82%

Steps

61%

Active

45%

Cal

7,842

1.8L

Steps  / 10K goal

Water  / 2.5L

78% complete

72% of goal

n Insight

You sleep better after yoga days.
n
Pattern over 14 days detected.

n

n

n

n

Home

Food

Workout

Health

Profile

The  dashboard  is  the  heart  of  FitKarma.  It  uses  a  bento-grid  layout  with  the  Karma  hero  card  at  top,  activity
Main Dashboard

rings,  quick-stat  mini-cards  (Steps,  Water),  and  an  AI  insights  card.  The  orange-accented  nav  bar  is  always

visible.

Figure UI-2 · Dashboard: Karma hero card, activity rings, bento quick-stats, AI insight card

Food & Nutrition Screens

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 117

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Food Log
nn nn nnnn

1,840

kcal  /  2200 goal

Nutrition AI

n

Carbs

Protein

Fat

Tap to scan food with camera

Breakfast  n
Poha, Tea

Lunch  nn
Dal Rice, Raita

Snack  nn
Fruits, Chai

412 kcal

680 kcal

220 kcal+

3 Dal Makhani detected
482 kcal
Confidence: 94%  ·  Portion: 1 bowl (~280g)

56g

Carbs

22g

18g

Protein

Fat

8g

Fibre

+ Log this meal

n Pitta-balancing  ·  Kapha-increasing

Figure UI-3 · Food log with macro rings and meal sections · AI scanner with detection confidence

Food Log Screen

AI Nutrition Scanner

Workout Screens

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 118

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Workout
nnnnnnn

n  Start Today's Workout

Upper Body · 45 min

All

Yoga

HIIT

Strength

Cardio

n
Surya Namaskar

n
HIIT Blast

Yoga

20 min

HIIT

30 min

n
n
n
Push-Pull

n

n
n
Morning Run
Health

n

Profile

Home

Food

Workout

Strength

45 min

Cardio

35 min

The  workout  screen

features  a  hero  gradient  card

Workout Library & Start

for

today's  recommended  session,

filter  chips

(Yoga/HIIT/Strength/Cardio), and a 2-column grid of workout cards with category, duration, and emoji icons.

Figure UI-4 · Workout library with filter chips, category cards, and today's workout hero CTA

Steps, Activity & Hydration

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 119

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Steps & Activity

Water Intake

1.8L

of 2.5L goal  ·  72%

Glass

200ml

Bottle

500ml

Custom

Today's Log

n 300 ml

n 200 ml

09:00

11:30

7,842

/ 10,000 steps

78% of daily goal

5.8 km

312

48 min

Distance

Calories

Active

Weekly Steps

Mon

Tue Wed

Thu

Fri

Sat

Sun

Figure UI-5 · Steps screen with large progress ring and 7-day bar chart · Water screen with wave fill

Steps & Activity

Water Intake

Sleep Tracking

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 120

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Sleep
nnnn

7h 20m

Last Night  ·  Good

Sleep Stages

REM

Light

Deep

82

Sleep Score  ·  Good

Sleep uses a deep navy-indigo 3-stop hero gradient. A crescent moon illustration doubles as a phase indicator.
Sleep Tracker Screen

Sleep  stages  are  shown  as  a  segmented  bar  (Awake  /  REM  /  Light  /  Deep).  The  sleep  score  is  prominently

displayed at 36sp.

Figure UI-6 · Sleep screen: duration hero, stage bar, quality score with deep space gradient

Health Monitoring Dashboard

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 121

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Health
nnnnnnnnn

⁄n 72 bpm

n 118/78

Heart Rate

Normal

Blood Pressure

Normal

n 98 mg/dL

n 98%

Blood Glucose

SpO2

Normal

Normal

n 7h 20m

n Low

Sleep

Normal

Stress

Normal

Blood Pressure

118/78

mmHg  ·  Today 09:30
Normal

30-day Trend

Systolic

Diastolic

120/80

118/78

116/76

08:00

12:30

21:00

Figure UI-7 · Health hub with 6-vital bento grid · BP detail with 30-day trend chart

Blood Pressure Tracker

Health Overview

Mental Health & Wellness

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 122

‹
FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Mental Wellness

How are you feeling?

n

n

n

n

n

Happy

Meh

Low

Stressed

Tired

n 14-day streak!

Keep journaling daily

-n  Open Journal

PHQ-9 Score:  4 / 27

Minimal depression range  ·  Last: 3 days ago

Next check-in recommended in 7 days

Mental Health features a mood picker (5 emoji options), journal streak flame, PHQ-9 score card, and a journal
Mental Wellness Screen

CTA button. Indigo-purple tones differentiate it from the orange-primary fitness screens.

Figure UI-8 · Mental wellness: mood picker, streak counter, journal access, PHQ-9 summary

ABHA Integration & Lab Reports

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 123

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

ABHA Health ID
Ayushman Bharat Health Account

Lab Report OCR

n ABHA

Ayushman Bharat Health Account

14-digit ABHA Number

91-1234-5678-9012

Linked Health Records

2 days ago

1 week ago

n Lab Results

n Prescription

Data Consent

Apollo Hospital requested access

3 Approve

7 Deny

n  Scan lab report

Works offline  ·  On-device OCR

Parsed Results

Glucose

98 mg/dL

Normal

HbA1c

5.4%

Total Cholesterol192

Normal

Normal

TSH

2.8 mIU/L
n  Share with Doctor

Normal

Figure UI-9 · ABHA card with linked records and consent flow · Lab OCR with parsed values

Lab Report OCR

ABHA Health ID

Community, Festival & Period Tracker

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 124

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Community

Cycle Tracker
n nnnnnnn nnnnnn

n  October Step Challenge

8,432 participants  ·  Ends in 8 days

n

Your rank: #234  ·  6,834 steps today

Leaderboard

Navratri Fitness Plan
nnnnnnnn  ·  9 Days  ·  Starts in 3 days

Priya S.

12,450 steps

n  Navratri Fasting Plan
Kuttu flour, Sabudana, Fruit diet

Calorie target: 1400 kcal/day

Amit K.

11,820 steps

Activate Plan

n

n

n

Meera P.

10,930 steps

  #4 Rahul S.

6,834 steps

Priya just hit 12K steps! n

P

Celebrated Navratri with a dance workout

⁄n  48  n  12  (cid:127)  2h ago

n  Garba Fitness Mode
Light yoga, Dandiya movements

Avoid heavy lifting during fast days

D1

D2

D3

D4

D5

D6

D7

D8

D9

Day 8

Follicular

n  Next period in 20 days

Cycle: 28 days  ·  Flow: Medium

Today's Symptoms

n Cramps

n Mood swings
n Bloating

n Fatigue

Figure UI-10 · Social challenge banner with leaderboard · Navratri festival planner · Period cycle wheel
Festival Planner
Period Tracker

Community Feed

Profile, Settings & Wearables

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 125

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Rahul Sharma
Level 8 · Warrior
n 1,247 Karma

R

42

Days

28

5

Workouts

Goals

n Notifications

n Privacy

n Dark Mode

›

›

›

Settings

Devices & Sync

ACCOUNT

n  Profile & Goals

n  Achievements

n  Health Summary

APP

n  Dark Mode

n  Notifications

n  Language

n  Accessibility

PRIVACY

n  Biometric Lock

nn  Data & Sync

›

›

›

›

›

›

›

n Mi Band 8 Pro

l Connected  ·  Battery 82%

Last sync: 2 min ago

Steps

Heart Rate

Sleep

SpO2

Add Device

n Apple Health

iOS

n Google Fit
Android

n Fitbit
Any

n Garmin
Any

Link

Link

Link

Link

Figure UI-11 · Profile with Karma stats hero · Settings with toggle controls · Wearable device connection
Profile Screen
Device Sync
Settings Screen

nn  Delete Data

›

n Share Report

›

PREMIUM

n  FitKarma Pro

›

n Subscription

›

Subscription Plans & Home Widgets

n  Subscription

›

n  Restore Purchase

›

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 126

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

n

FitKarma Pro
Unlock your full potential

Monthly
n99/mo

BEST

Yearly
n799/yr

Save 33%

Lifetime
n1,999

3  AI Nutrition Scanner

Start Free Trial  ﬁ

Home Widgets

FitKarma  ·  Today

7,842
steps

312

Cal

1.8L

Water

7h

Sleep

Karma

Streak

1,247

pts

n 14

Level 8 Warrior

days active

Figure UI-12 · Pro subscription with pricing tiers · Android/iOS home widget gallery (2×2, 2×1, 1×1)

FitKarma Pro Plans

Home Screen Widgets

Shared Component Library

The following 28 shared components are available across all feature modules. They enforce design consistency

and are the building blocks of every screen.

Component

GlassCard

Description

Used in

BackdropFilter blur + glass overlay

All dashboard cards

GlowingMetric

Large number with drop-shadow glow

Dashboard, BP, Steps hero

ActivityRing

Animated SVG ring with CountUp

Dashboard, Steps, Profile

BentoGrid

Variable-size card grid layout

Dashboard, Health, Social

BilingualLabel

English + Hindi label row

All section headers

KarmaChip

Amber XP badge with animation

Dashboard, Log confirmations

StreakFlameWidget

Lottie fire animation

Dashboard, Social

MacroRingChart

3-ring donut for macros

Food log, Meal plan

GlassBottomSheet

Draggable glass sheet

All log actions

TrendChip

s/t/ﬁ trend indicator pill

BP, Glucose, Sleep score

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 127

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Component

InsightCard

Description

Used in

Secondary-glow correlation card

Dashboard, Health

SyncStatusBanner

Amber DLQ / Teal offline banners

Global scaffold

PrimaryButton

Full-width orange CTA

All primary actions

GlassTextField

Focus-glow input field

All log forms

EncryptionBadge

n lock icon badge

BP, Period, Journal screens

FoodCard

Food thumb + macros + bilingual

Search, Meal plan

WorkoutCard

Category icon + duration + level

Workout library

HealthValueRow

Label + value + status pill

Lab results, vitals

ProgressBar

Animated filled bar

Goals, steps, water

AvatarCircle

User initials + level ring

Profile, Social, Nav

DoshaTag

Teal Ayurveda classification

Food cards, Nutrition

DateScrollPicker

Horizontal date chips

All log screens

EmptyStateIllustration

Lottie empty states

All empty list states

ChipFilter

Scrollable filter chips

Workout, Food search

ShimmerCard

Shimmer loading placeholder

Remote content only

MoodEmoji

Animated emoji mood selector

Mood log screen

FestivalBanner

Ambient festival context card

Dashboard, Festival

QuickLogFab

Expandable speed dial FAB

Dashboard, Food, Water

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 128

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Accessibility & Bilingual Summary

FitKarma  meets  or  exceeds  WCAG  AA  contrast  requirements  for  all  text.  Bilingual  labelling  is  applied

strategically — not on every element — to maximise comprehension without cluttering the UI.

Standard

Requirement

FitKarma Implementation

WCAG AA contrast

4.5:1 minimum

All  text  meets  or  exceeds  —  glow  never  counted

toward ratio

Tap target

44×44px min

All buttons, chips, row icons enforced

Screen reader

Semantic labels

All IconButton + Image have Semantics

Font scaling

Respects system size

No hardcoded textScaleFactor overrides

Dyslexia font

OpenDyslexic option

Toggle in Settings ﬁ Preferences

High contrast mode

Zero gradients

Black/white/orange — all blur disabled

Motion reduce

No animations

Cross-fade fallback on disableAnimations

Bilingual labels

Strategic only

Nav, section headers, food names, lab values

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 129

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ APP
Appendix

Packages · Dependencies · Changelog

A. pubspec.yaml — Key Dependencies

dependencies:
  flutter_riverpod:        ^2.4.9
  riverpod_annotation:     ^2.3.3
  drift:                   ^2.14.1
  sqlite3_flutter_libs:    ^0.5.18
  appwrite:                ^11.0.1
  flutter_secure_storage:  ^9.0.0
  local_auth:              ^2.1.7
  workmanager:             ^0.5.0
  connectivity_plus:       ^5.0.2
  fl_chart:                ^0.66.0
  lottie:                  ^3.0.0
  rive:                    ^0.12.0
  google_fonts:            ^6.1.0
  razorpay_flutter:        ^1.3.7
  home_widget:             ^0.4.1
  firebase_messaging:      ^14.7.9   # FCM only
  sentry_flutter:          ^7.14.0
  cached_network_image:    ^3.3.1
  image_picker:            ^1.0.4
  flutter_barcode_scanner: ^1.0.0
  speech_to_text:          ^6.3.0
  health:                  ^9.0.0
  shimmer:                 ^3.0.0
  flutter_local_notifications: ^16.1.0
  url_launcher:            ^6.2.5
  pdf:                     ^3.10.0
  flutter_quill:           ^9.0.0
  just_audio:              ^0.9.0

B. Changelog Summary

Version

Key Changes

2.0.0

2.0.0

2.0.0

2.0.0

2.0.0

2.0.0

2.0.0

Sync engine upgraded: idempotency keys, DLQ, per-field version vectors

Encryption re-architected: HKDF per data class stored in Drift (SQLCipher)

First-class RemoteConfig system added (Appwrite-backed)

Insight engine modularised with server-updatable rules

India-specific: ABHA, Lab Report OCR, shareable doctor reports

Home screen widgets: Android Glance + iOS WidgetKit

WhatsApp bot integration for food/water logging

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 130

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Version

Key Changes

2.0.0

2.0.0

2.0.0

2.0.0

2.0.0

2.0.0

1.5.0

1.4.0

1.3.0

1.2.0

1.1.0

1.0.0

Full dark mode token set + light mode warm inversion

Offline map tile caching for workout routes

Glassmorphism UI: bento-grid, spring physics, Lottie/Rive animations

Festival planner: Navratri, Karva Chauth, Ekadashi fasting adapters

iOS CI/CD: code signing, App Store Connect provisioning

Staging Appwrite deploy pipeline added

Razorpay subscription billing, Karma economy system

Mental health: PHQ-9, GAD-7, encrypted journal

Period tracker with ML cycle prediction

Fitbit/Garmin/Apple Health/Google Fit wearable sync

Ayurveda engine: dosha quiz, food tagging, herb DB

Initial release: nutrition, workout, steps, sleep, water

FitKarma — Developer & UI Documentation

India's Most Affordable, Culturally-Rich Fitness Platform

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Offline-First  ·  Privacy-Centric  ·  35+ Modules  ·  45+ Screens

Full Bilingual UI  ·  Dark-First Design  ·  28 Shared Components

ABHA Integration  ·  Lab Report OCR  ·  Ayurveda Engine  ·  WhatsApp Bot

© 2025 FitKarma Engineering — All rights reserved

Documentation Version 2.0  ·  For internal and developer use

§ 25
Riverpod Provider Catalogue

All 80+ Providers Reference

25.1 Infrastructure Providers

Provider Name

Type

Returns

Notes

appwriteClientProvider

Provider

Client

Singleton

Appwrite

SDK client

databaseProvider

Provider

AppDatabase

Drift DB singleton

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 131

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Provider Name

Type

Returns

Notes

syncEngineProvider

Provider

SyncEngine

encryptionServiceProvider

Provider

connectivityProvider

StreamProvider

EncryptionServic

e

ConnectivityResu

lt

Background

sync

orchestrator

HKDF key manager

Network state stream

biometricServiceProvider

Provider

BiometricService

Local auth wrapper

remoteConfigProvider

FutureProvider

RemoteConfig

Appwrite RC fetch

themeNotifierProvider

NotifierProvider

ThemeMode

Dark/Light/System

currentUserProvider

FutureProvider

User?

Appwrite session user

userProfileProvider

FutureProvider

UserProfile

Drift user document

subscriptionProvider

FutureProvider

SubscriptionTier

Razorpay + Drift

languageProvider

NotifierProvider

Locale

Selected app language

deviceTierProvider

Provider

DeviceTier

low/mid/high detection

dlqCountProvider

StreamProvider

pendingSyncCountProvider

StreamProvider

int

int

Dead  Letter  Queue

item count

Unsynced items count

25.2 Nutrition Providers

Provider Name

Type

Returns

Trigger

foodLogNotifierProvider

AsyncNotifierProvider

List

Drift stream

todayMacrosProvider

FutureProvider

MacroTotals

Sum today's logs

calorieGoalProvider

FutureProvider

foodSearchProvider

FamilyProvider

int

List

TDEE + activity

Debounced search

mealPlanProvider

FutureProvider

MealPlan

Current week plan

recipeProvider

FamilyProvider

Recipe

By recipe ID

recentFoodsProvider

FutureProvider

favouriteFoodsProvider

StreamProvider

List

List

Last 20 unique

Drift watch

nutritionGoalsProvider

FutureProvider

NutritionGoals

User + activity

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 132

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Provider Name

Type

Returns

Trigger

weeklyCalorieSummaryProvider

FutureProvider

List

7-day history

aiScannerProvider

AsyncNotifierProvider

ScanResult?

On-demand

ayurvedicFoodTagProvider

FamilyProvider

DoshaTag

By food ID

25.3 Health & Wellness Providers

Provider Name

bpLogsProvider

Type

Returns

StreamProvider

List

latestBpProvider

FutureProvider

BpLog?

bpTrendProvider

FutureProvider

BpTrend

glucoseLogsProvider

StreamProvider

List

latestGlucoseProvider

FutureProvider

GlucoseLog?

spo2LogsProvider

StreamProvider

sleepLogProvider

StreamProvider

sleepScoreProvider

FutureProvider

sleepInsightsProvider

FutureProvider

moodLogProvider

StreamProvider

List

List

int

List

List

moodTrendProvider

FutureProvider

MoodTrend

journalEntriesProvider

StreamProvider

List

phq9ScoreProvider

FutureProvider

Phq9Score?

periodLogsProvider

StreamProvider

List

cycleInsightProvider

FutureProvider

CycleInsight

medicationScheduleProvider

StreamProvider

List

adherenceScoreProvider

FutureProvider

double

stepLogProvider

FamilyProvider

StepLog?

weeklyStepsProvider

FutureProvider

waterLogProvider

StreamProvider

waterGoalProvider

FutureProvider

List

List

int

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 133

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

25.4 Social & Gamification Providers

Provider Name

Type

Returns

karmaNotifierProvider

NotifierProvider

KarmaState

karmaHistoryProvider

FutureProvider

List

streakProvider

StreamProvider

StreakInfo

activeChallengesProvider

FutureProvider

challengeLeaderboardProvider

FamilyProvider

feedProvider

friendsProvider

FutureProvider

FutureProvider

achievementsProvider

StreamProvider

pendingAchievementsProvider

FutureProvider

List

List

List

List

List

List

socialFeedSettingsProvider

NotifierProvider

FeedSettings

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 134

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

All 45+ Screens — Layout, Components, State

§ 26
Screen Specifications

26.1 Screen Inventory

#

0

1

0

2

0

3

0

4

0

5

0

6

0

7

0

8

0

9

1

0

1

1

1

2

1

3

1

4

Screen Name

Route

Module

Auth Required

Splash

/ (initial)

core

Onboarding Step 1

/onboard/name

auth

Onboarding Step 2

/onboard/body

auth

Onboarding Step 3

/onboard/goals

auth

Onboarding Step 4

/onboard/language

auth

Onboarding Step 5

/onboard/abha

auth

Login / OTP

/auth/login

OTP Verify

/auth/verify

auth

auth

No

No

No

No

No

No

No

No

Dashboard

/home

dashboard

Yes

Karma Detail

/karma

dashboard

Yes

Food Log

/food

nutrition

Yes

Food Search

/food/search

nutrition

Yes

Food Detail

/food/:id

nutrition

Yes

AI Food Scanner

/food/scan

nutrition

Yes (Pro)

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 135

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

#

1

5

1

6

1

7

1

8

1

9

2

0

2

1

2

2

2

3

2

4

2

5

2

6

2

7

2

8

2

9

3

0

3

1

Screen Name

Route

Module

Auth Required

Meal Plan

/meal-plan

nutrition

Yes (Pro)

Recipe List

/recipes

nutrition

Yes

Recipe Detail

/recipes/:id

nutrition

Yes

Workout Home

/workout

workout

Yes

Workout Detail

/workout/:id

workout

Yes

Active Workout

/workout/active

workout

Yes

Exercise Library

/workout/exercises

workout

Yes

Steps & Activity

/steps

steps

Route Map

/steps/map

steps

Sleep Tracker

/sleep

Water Intake

/water

sleep

water

Health Overview

/health

health

Blood Pressure

/health/bp

health

Blood Glucose

/health/glucose

health

SpO2 Monitor

/health/spo2

health

Lab Reports

/health/labs

health

Medication

/health/meds

health

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Yes

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 136

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

#

3

2

3

3

3

4

3

5

3

6

3

7

3

8

3

9

4

0

4

1

4

2

4

3

4

4

4

5

4

6

4

7

4

8

Screen Name

Route

Module

Auth Required

ABHA Integration

/health/abha

health

Yes

Mental Wellness

/mental

mental

Yes

Journal

/mental/journal

mental

Yes (Biometric)

Meditation

/mental/meditate

mental

Yes

Breathing

/mental/breathing

mental

Yes

Period Tracker

/period

period

Yes (Biometric)

Community Feed

/social

social

Challenges

/social/challenges

social

Leaderboard

/social/leaderboard

social

Yes

Yes

Yes

Festival Planner

/festival

festival

Yes

Ayurveda Hub

/ayurveda

ayurveda

Yes

Devices & Sync

/devices

wearables

Yes

Profile

/profile

profile

Yes

Settings

/settings

settings

Yes

Subscription

/settings/subscription

settings

Yes

Privacy & Data

/settings/privacy

settings

Yes

Notifications

/settings/notifications

settings

Yes

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 137

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

26.2 Dashboard Screen — Full Spec

Element

Component

State Dependency

Interaction

Header bar

Karma hero

GlassCard

(surface1)

GlowingMetric  +  XP

bar

currentUserProvider

Avatar ﬁ /profile

karmaNotifierProvider

Tap ﬁ /karma

Activity rings

ActivityRing ×3

todayMacrosProvider

+

stepLogProvider

Tap each ﬁ detail screen

Steps mini-card

BentoCard (1/2)

stepLogProvider(today)

Water mini-card

BentoCard (1/2)

waterLogProvider

Tap ﬁ /steps

Tap ﬁ /water

AI Insight card

InsightCard

(surface1)

insightProvider

Dismiss or open detail

DLQ banner

SyncStatusBanner

dlqCountProvider

Tap ﬁ /settings/data

Offline banner

SyncStatusBanner

connectivityProvider

Auto-dismiss on reconnect

Bottom nav

GlassNavBar

currentRouteProvider

5 tabs

QuickLog FAB

Festival banner

QuickLogFab

(expandable)

FestivalBanner

(conditional)

—

Food / Water / Workout shortcuts

remoteConfigProvider

Tap ﬁ /festival

26.3 Food Log Screen — Full Spec

Element

Component

Notes

Date scroll

DateScrollPicker

Swipe left/right to change day

Calorie doughnut

MacroRingChart

Animated on data change

Macro bar row

ProgressBar ×3

Carbs / Protein / Fat colour-coded

Meal sections ×4

MealSection (expandable)

Breakfast/Lunch/Dinner/Snack

Food item row

FoodCard (compact)

Long-press to edit/delete

FAB

QuickLogFab

Expands: Camera / Search / Voice / Barcode

Empty state

EmptyStateIllustration

(Lottie)

Shown when no logs for selected day

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 138

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Element

Component

Notes

Water quick-add

WaterChip row

200ml / 500ml / custom at bottom

Calorie goal ring

GlowingMetric

Pulses amber when > 90% of goal

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 139

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 27
Complete Drift Table Schemas

All 18 Local Tables with DAOs

27.1 All Drift Tables

Table: food_log_table

Column

id

user_id

food_id

qty_g

meal_type

logged_at

kcal

protein_g

carbs_g

fat_g

fibre_g

synced

sync_id

Type/Constraint

Int AUTO PK

Text

Text

Real

Text enum

DateTime

Real

Real

Real

Real

Real

Bool default F

Text? UUID

Table: step_log_table

Column

id

user_id

date

steps

distance_km

calories

Type/Constraint

Int AUTO PK

Text

Text YYYY-MM-DD

Int

Real

Real

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 140

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Column

active_min

source

synced

sync_id

Type/Constraint

Int

Text enum

Bool

Text?

Table: sleep_log_table

Column

id

user_id

date

sleep_start

sleep_end

duration_min

deep_min

rem_min

light_min

awake_min

score

source

synced

sync_id

Type/Constraint

Int AUTO PK

Text

Text

DateTime

DateTime?

Int

Int

Int

Int

Int

Int

Text

Bool

Text?

Table: water_log_table

Column

id

user_id

logged_at

amount_ml

Type/Constraint

Int AUTO PK

Text

DateTime

Int

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 141

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Column

Type/Constraint

source_type

synced

sync_id

Text

Bool

Text?

Table: bp_log_table

Column

id

user_id

systolic

diastolic

pulse

arm

posture

notes

Type/Constraint

Int AUTO PK

Text

Int

Int

Int

Text

Text

Text?

logged_at

DateTime

synced

sync_id

Bool

Text?

Table: glucose_log_table

Column

id

user_id

value_mg_dl

measure_type

hba1c_pct

logged_at

synced

sync_id

Type/Constraint

Int AUTO PK

Text

Real

Text

Real?

DateTime

Bool

Text?

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 142

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Table: mood_log_table

Column

id

user_id

score

emotions_json

Type/Constraint

Int AUTO PK

Text

Int 1-5

Text

journal_enc

Text AES

iv

Text

logged_at

DateTime

synced

sync_id

Bool

Text?

Table: period_log_table

Column

id

user_id

cycle_start

cycle_end

flow

symptoms_json

notes_enc

synced

sync_id

Type/Constraint

Int AUTO PK

Text

DateTime

DateTime?

Text

Text

Text?

Bool

Text?

Table: medication_table

Column

id

user_id

name

Type/Constraint

Int AUTO PK

Text

Text

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 143

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Column

dosage

unit

frequency

schedule_json

start_date

end_date

active

Type/Constraint

Text

Text

Text

Text

DateTime

DateTime?

Bool

Table: medication_log_table

Column

id

med_id

user_id

taken_at

skipped

notes

synced

Type/Constraint

Int AUTO PK

Int FKﬁmedication

Text

DateTime

Bool

Text?

Bool

Table: sync_queue_table

Column

id

operation

collection

document_id

Type/Constraint

Text UUID PK

Text

Text

Text

payload

Text JSON

retry_count

Int

created_at

next_retry

DateTime

DateTime

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 144

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Table: dead_letter_queue_table

Column

id

collection

payload

error_msg

failed_at

Type/Constraint

Text UUID PK

Text

Text

Text

DateTime

acknowledged

Bool

Table: workout_session_table

Column

id

user_id

plan_id

started_at

ended_at

duration_min

calories

exercises_json

notes

synced

sync_id

Type/Constraint

Int AUTO PK

Text

Text?

DateTime

DateTime?

Int

Real

Text

Text?

Bool

Text?

Table: remote_config_table

Column

key

value

Type/Constraint

Text PK

Text

updated_at

DateTime

Table: food_item_cache_table

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 145

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Column

Type/Constraint

id

name

brand

kcal_100g

protein_100g

carbs_100g

fat_100g

fibre_100g

dosha_tag

cached_at

Text PK

Text

Text?

Real

Real

Real

Real

Real

Text?

DateTime

Table: user_table

Column

Type/Constraint

id

name

phone

dob

height_cm

weight_kg

goal

activity

subscription

karma

streak

language

Text PK

Text

Text

DateTime

Real

Real

Text

Text

Text

Int

Int

Text

Table: achievement_table

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 146

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Column

id

user_id

badge_id

Type/Constraint

Text PK

Text

Text

awarded_at

DateTime

notified

Bool

Table: notification_log_table

Column

Type/Constraint

id

type

sent_at

payload

Int AUTO PK

Text

DateTime

Text

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 147

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 28
Navigation Reference

28.1 Route Configuration

GoRouter 7.x — All Routes & Guards

// lib/core/router/app_router.dart
final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(currentUserProvider);
  return GoRouter(
    initialLocation: '/',
    refreshListenable: ref.watch(routerRefreshListenable),
    redirect: (context, state) {
      final isAuth = authState.valueOrNull != null;
      final isOnboarding = state.matchedLocation.startsWith('/onboard');
      final isAuth2 = state.matchedLocation.startsWith('/auth');
      if (!isAuth && !isOnboarding && !isAuth2) return '/auth/login';
      if (isAuth && isAuth2) return '/home';
      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (_, __) => const SplashScreen()),
      ShellRoute(
        builder: (ctx, state, child) => MainScaffold(child: child),
        routes: [
          GoRoute(path: '/home',         builder: (_, __) => const DashboardScreen()),
          GoRoute(path: '/food',         builder: (_, __) => const FoodLogScreen()),
          GoRoute(path: '/food/search',  builder: (_, s)  => FoodSearchScreen(query: s.uri.queryParameters['q'])),
          GoRoute(path: '/food/scan',    builder: (_, __) => const AiScannerScreen()),
          GoRoute(path: '/food/:id',     builder: (_, s)  => FoodDetailScreen(id: s.pathParameters['id']!)),
          GoRoute(path: '/workout',      builder: (_, __) => const WorkoutHomeScreen()),
          GoRoute(path: '/workout/active',builder:(_, s)  => ActiveWorkoutScreen(sessionId: s.extra as String)),
          GoRoute(path: '/steps',        builder: (_, __) => const StepsScreen()),
          GoRoute(path: '/sleep',        builder: (_, __) => const SleepScreen()),
          GoRoute(path: '/water',        builder: (_, __) => const WaterScreen()),
          GoRoute(path: '/health',       builder: (_, __) => const HealthDashboardScreen()),
          GoRoute(path: '/health/bp',    builder: (_, __) => const BloodPressureScreen()),
          GoRoute(path: '/health/glucose',builder:(_, __)=> const GlucoseScreen()),
          GoRoute(path: '/health/labs',  builder: (_, __) => const LabReportsScreen()),
          GoRoute(path: '/health/abha',  builder: (_, __) => const AbhaScreen()),
          GoRoute(path: '/mental',       builder: (_, __) => const MentalWellnessScreen()),
          GoRoute(path: '/mental/journal',builder:(_, __)=> const JournalScreen()),
          GoRoute(path: '/period',       builder: (_, __) => const PeriodTrackerScreen()),
          GoRoute(path: '/social',       builder: (_, __) => const CommunityFeedScreen()),
          GoRoute(path: '/festival',     builder: (_, __) => const FestivalPlannerScreen()),
          GoRoute(path: '/ayurveda',     builder: (_, __) => const AyurvedaHubScreen()),
          GoRoute(path: '/devices',      builder: (_, __) => const DevicesScreen()),
          GoRoute(path: '/profile',      builder: (_, __) => const ProfileScreen()),
          GoRoute(path: '/settings',     builder: (_, __) => const SettingsScreen()),
          GoRoute(path: '/settings/subscription', builder: (_, __) => const SubscriptionScreen()),
          GoRoute(path: '/karma',        builder: (_, __) => const KarmaDetailScreen()),
        ],
      ),
      GoRoute(path: '/auth/login',  builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/auth/verify', builder: (_, s)  => OtpVerifyScreen(phone: s.extra as String)),
      GoRoute(path: '/onboard/name',builder: (_, __) => const OnboardingNameScreen()),
    ],
  );
});

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 148

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

28.2 Navigation Guards

Guard

Condition

Auth guard

currentUser == null

Redirect

ﬁ /auth/login

Onboarding guard

user.profileComplete == false

ﬁ /onboard/name

Subscription guard

tier == free AND Pro feature

ﬁ /settings/subscription

Biometric guard

biometricLock

enabled

AND

sensitive screen

Biometric dialog inline

Low

guard

connectivity

isOffline AND remote-only screen

Offline state widget

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 149

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 29
Appwrite Indexes & Queries

Performance-Critical Index Reference

Collection

food_logs

food_logs

step_logs

step_logs

Index Key(s)

Type

Used In

[user_id, logged_at]

Compound

Today's log, weekly summary

[user_id, meal_type]

Compound

Meal section grouping

[user_id, date]

Compound

Daily steps lookup

[user_id, date DESC]

Compound

Weekly steps chart (last 7)

sleep_logs

[user_id, date DESC]

Compound

Sleep history pagination

bp_logs

[user_id, logged_at DESC]

Compound

Latest reading, 30-day trend

glucose_logs

[user_id,

logged_at]

measure_type,

Compound

Fasting vs post-meal filter

mood_logs

[user_id, logged_at DESC]

Compound

Journal history

period_logs

[user_id, cycle_start DESC]

Compound

Current cycle detection

workout_sessions

[user_id, started_at DESC]

Compound

History pagination

medication_logs

[med_id, taken_at]

Compound

Adherence calculation

users

users

users

[phone]

Unique

Auth phone lookup

[karma_points DESC]

Single

Global leaderboard

[city, karma_points DESC]

Compound

City leaderboard

food_items

[$search]

Full-text

Food name search (FTS5)

challenges

[status, end_date]

Compound

Active challenge listing

feed_posts

[user_id, created_at DESC]

Compound

User feed pagination

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 150

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

FCM Payload Design · Smart Scheduling · Deep Links

§ 30
Notification System

30.1 Notification Types

Type ID

Title Template

Body Template

Deep Link

Priority

streak_risk

n  Don't  break  your
streak!

Log  one  activity  to  keep

your {n}-day streak alive

/home

High

daily_reminder

Good

{time_of_day},

Log  your  {meal}  to  stay

{name}!

on track

/food

Normal

challenge_update

Challenge Update n

You're

#{rank}

in

/social/challeng

{challenge_name}

es

Normal

water_reminder

n Hydration check

bp_log_reminder

Track your BP

step_goal

n Goal reached!

insight

n New insight for you

You've  had  {amount}ml

today. Goal: {goal}ml

You haven't logged BP in

{days} days

You  hit

{steps}  steps

today! Keep going

FitKarma

noticed:

{insight_text}

/water

Normal

/health/bp

Normal

/steps

Normal

/health

Low

medication

n Medication reminder

{med_name} at {time}

/health/meds

High

refill

n Refill reminder

{days_left}

days

{med_name}

—

of

/health/meds

Normal

level_up

nn Level Up!

challenge_end

Challenge complete!

lab_insight

Lab results analyzed

period_reminder

n Cycle reminder

supply left

You

reached

Level

{level}: {title}!

Final

rank:

#{rank}.

Earned {xp} karma XP

Your  {test}  reading

is

{value} — {status}

Your  period  may  start  in

{days} days

/karma

High

/social

Normal

/health/labs

Normal

/period

Normal

maintenance

Scheduled

maintenance

FitKarma  will  be  offline

{time_window}

/settings

Low

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 151

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

30.2 Smart Scheduling Rules

// lib/core/services/notification_scheduler.dart
class NotificationScheduler {

  // Never send during sleep window
  static bool isInSleepWindow(DateTime now, TimeOfDay sleepStart, TimeOfDay wakeTime) {
    final nowMinutes = now.hour * 60 + now.minute;
    final sleepMinutes = sleepStart.hour * 60 + sleepStart.minute;
    final wakeMinutes = wakeTime.hour * 60 + wakeTime.minute;
    if (sleepMinutes > wakeMinutes) { // crosses midnight
      return nowMinutes >= sleepMinutes || nowMinutes < wakeMinutes;
    }
    return nowMinutes >= sleepMinutes && nowMinutes < wakeMinutes;
  }

  // Cap daily notification volume
  static const maxPerDay = 6;
  static const maxHighPriorityPerDay = 2;

  // Streak risk notification: only if not logged any activity by 20:00 IST
  Future<void> scheduleStreakRiskCheck() async {
    await Workmanager().registerOneOffTask(
      'streak_check',
      'checkStreakRisk',
      initialDelay: _delayUntil(TimeOfDay(hour: 20, minute: 0)),
      constraints: Constraints(networkType: NetworkType.not_required),
    );
  }
}

30.3 Low Data Mode Adaptations
When the user enables Low Data Mode in Settings ﬁ Data & Sync, all FCM payloads are sent as data-only (no
images, no rich media). The app processes these silently and schedules local notifications instead.

Normal Mode

Low Data Mode

FCM with notification + data payload

FCM data-only payload

Rich notification with image

Text-only local notification

Background sync every 15 min

Background sync every 60 min

Prefetch 7-day meal plan images

No image prefetch

Workout video auto-download

Manual download only

Feed post images loaded eagerly

Placeholder, tap to load

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 152

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 31
Ayurveda Module Deep-Dive

Dosha Engine · Food Tags · Herb DB

31.1 Dosha Quiz Algorithm

// lib/features/ayurveda/domain/dosha_calculator.dart
class DoshaCalculator {
  // 25 questions, each answered 1–5 (mostly Vata / mostly Kapha, etc.)
  // Scores aggregated into Vata, Pitta, Kapha totals

  DoshaProfile calculate(List<int> answers) {
    double vata = 0, pitta = 0, kapha = 0;

    for (int i = 0; i < answers.length; i++) {
      final q = _questions[i];
      vata  += answers[i] * q.vataWeight;
      pitta += answers[i] * q.pittaWeight;
      kapha += answers[i] * q.kaphaWeight;
    }

    final total = vata + pitta + kapha;
    return DoshaProfile(
      vata: vata / total,
      pitta: pitta / total,
      kapha: kapha / total,
      dominant: _dominant(vata, pitta, kapha),
    );
  }
}

// Dosha profile used throughout app:
// - Food log shows dosha-balance impact per meal
// - Meal planner generates dosha-aligned 7-day plan
// - Workout recommends intensity level per dosha
// - Sleep coach tailors bedtime advice per dosha

31.2 Food Dosha Database

Food

Ghee

Honey

Vata Effect

Pitta Effect

Kapha Effect

Notes

Decreases

Neutral

Increases

Sattvic, digestive fire

Decreases

Increases

Decreases

Never heat — toxic per Ayurveda

Milk (warm)

Decreases

Decreases

Increases

Best at night

Curd/Yogurt

Decreases

Increases

Increases

Avoid at night

Dal (moong)

Decreases

Decreases

Decreases

Tridoshic, easy digest

Red chili

Increases

Increases

Decreases

Pacifies Kapha only

Coconut water

Decreases

Decreases

Neutral

Summer Pitta remedy

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 153

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Food

Vata Effect

Pitta Effect

Kapha Effect

Notes

Dry fruits

Decreases

Increases

Increases

Good for Vata, moderate

White rice

Decreases

Decreases

Increases

Easy on gut, post-illness

Bitter gourd

Increases

Decreases

Decreases

Blood sugar balancing

Turmeric

Neutral

Decreases

Decreases

Anti-inflammatory

Ginger

Decreases

Increases

Decreases

Digestive  aid  —  use  sparingly  for

Pitta

31.3 Seasonal Routines (Ritucharya)

Season (Ritu)

Approx Months

Dominant Dosha

Dietary Focus

Exercise

Shishira (Winter)

Dec–Jan

Vata+Kapha

Warm, oily, sweet

Vigorous daily

Vasanta (Spring)

Feb–Mar

Kapha

Light, bitter, pungent

Increase intensity

Grishma (Summer)

Apr–Jun

Pitta

Cool, sweet, liquid

Light,

morning

early

Varsha (Monsoon)

Jul–Aug

Vata+Pitta

Sour,

salty,

easily

digestible

Moderate indoor

Sharad (Autumn)

Sep–Oct

Pitta

Bitter, sweet, cooling

Moderate

Hemanta

(Late

Autumn)

Nov

Kapha

Nourishing, warm

Strength training

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 154

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 32
Karma Economy — Full Design

XP · Levels · Badges · Multipliers

32.1 XP Multiplier System

Karma XP is not simply flat — multipliers reward consistency and engagement depth.

Multiplier

Condition

Effect

Streak multiplier

Active streak × 0.02 (cap: 2.0×)

7-day streak = 1.14×, 30-day = 1.60×

Weekend warrior

5+ activities on Sat/Sun

1.5× XP for weekend logs

Festival mode

Active festival in RemoteConfig

1.25× XP during festival week

Challenge participant

Enrolled in any active challenge

1.2× on relevant activity

Pro subscriber

Active Pro/Lifetime subscription

1.15× baseline XP always

Family plan

2+ family members on app

1.1× per linked member (max 1.3×)

Perfect day

All 5 core goals met in one day

100 bonus XP (not multiplied)

Data-rich log

BP + glucose + sleep all logged in a

day

50 bonus XP

32.2 Achievement Badge System

Badge ID

Name

Criteria

step_1k

First Steps

Log first 1,000 steps

XP

50

Visual

Bronze sneaker

step_marathon

Marathon Walker

Cumulative 42,195 steps

500

Gold medal

streak_7

Week Warrior

7-day consecutive activity

100

Fire ×1

streak_30

Monthly Master

30-day streak

500

Fire ×3

streak_100

Century Club

100-day streak

2000

Diamond flame

food_30

Mindful Eater

Log food 30 consecutive days

300

Green leaf

water_goal_7

Hydration Hero

Hit water goal 7 days in a row

100

Water drop

sleep_score_8

0

Deep Sleeper

Sleep score ‡80 for 7 nights

200

Moon

bp_log_30

Heart Keeper

Log BP 30 days

200

Red heart

all_goals

Perfect Day

Hit all 5 goals in one day

100

Gold star

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 155

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Badge ID

Name

Criteria

first_workout

First Sweat

Complete first workout

XP

50

Visual

Dumbbell

workout_100

Century Athlete

Complete 100 workout sessions

1000

Trophy

karma_1000

Karma Collector

Reach 1,000 karma points

50

Lotus

karma_10000

Karma Legend

Reach 10,000 karma points

200

Crown

friend_10

Social Warrior

Connect with 10 friends

50

Hands

challenge_win

Challenge

Champion

Finish #1 in a challenge

500

Podium #1

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 156

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 33
Error Handling & Resilience

Sentry · DLQ · User-Facing States

33.1 Error Taxonomy

Error Class

Examples

User Visible

Recovery

Network timeout

Appwrite unreachable

Offline banner

Auto-retry in 30s

Auth expired

Session token expired

Toast:

'Session

expired'

Auto re-auth via refresh token

Sync conflict

DLQ overflow

Version  mismatch  on

Silent merge in 90%

update

cases

User prompt on critical fields

5+

consecutive

sync

Amber

warning

failures

banner

Settings ﬁ Data & Sync review

Encryption failure

Corrupt derived key

Full-screen  error  +

logout

Re-authenticate to re-derive key

Storage full

Device disk < 50MB free

Toast + storage info

Delete old cache from Settings

OCR failure

Lab report unreadable

'Could  not  parse  —

try again'

Manual entry fallback

Payment failure

Razorpay gateway error

Full error dialog

Retry or contact support

Appwrite 429

Rate limit exceeded

Wearable

disconnect

Fitbit auth revoked

AI scanner down

Function timeout

Silent: pause sync 5

min

Toast:

'Device

disconnected'

Toast:

'AI

unavailable'

Exponential backoff

Re-link in Devices screen

Fallback to manual/barcode

Crash (Dart)

Unhandled exception

App restarts

Sentry auto-capture

33.2 Sentry Integration

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 157

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

// lib/main.dart
await SentryFlutter.init(
  (options) {
    options.dsn = AppConfig.sentryDsn;
    options.tracesSampleRate = kDebugMode ? 0.0 : 0.1;  // 10% perf traces in prod
    options.profilesSampleRate = 0.1;
    options.attachScreenshot = true;
    options.environment = AppConfig.environment;
    options.release = AppConfig.versionName;
    // Scrub PII from breadcrumbs
    options.beforeBreadcrumb = (crumb, hint) {
      if (crumb.data?.containsKey('phone') ?? false) {
        crumb.data!['phone'] = '***REDACTED***';
      }
      return crumb;
    };
    // Filter sensitive routes from traces
    options.tracesSampler = (context) {
      if (context.transactionContext.name.contains('/mental/journal')) return 0.0;
      if (context.transactionContext.name.contains('/period')) return 0.0;
      return 0.1;
    };
  },
  appRunner: () => runApp(ProviderScope(child: FitKarmaApp())),
);

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 158

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 34
Wearable Integration

Fitbit · Garmin · Apple Health · Google Fit

34.1 Wearable Data Flow

ﬁ  Apple HealthKit / Google Fit

// Wearable Sync Architecture
Wearable Device
    n
    n  (Platform SDK — Health, HealthKit, FitbitSDK, GarminSDK)
    t
health Package (Flutter)  ‹
    n
    t
WearableRepository
    n  normalize to FitKarma model (steps, HR, sleep, SpO2)
    t
Drift (local cache + merge)
    n  merge: take max(phone_steps, wearable_steps) per day
    t
SyncEngine ﬁ Appwrite

// Data merge priority for steps:
// 1. Wearable (most accurate)  >  2. Phone pedometer  >  3. Manual entry

34.2 OAuth Flows by Platform

Platform

Auth Flow

Scopes Requested

Refresh Strategy

Fitbit

OAuth 2.0 PKCE

activity,

heartrate,

sleep,

oxygen_saturation

Token

stored

in

flutter_secure_storage,

refresh  1h

before expiry

Garmin

OAuth  1.0a  +

PKCE

All Health Snapshot data

Same secure storage, daily refresh

Apple HealthKit

iOS

permission

HKWorkout,

HKQuantity

No

tokens  —

permission

is

dialog

(steps, HR, SpO2, sleep)

permanent

Google Fit

OAuth 2.0

fitness.activity,

fitness.sleep,

fitness.body

Token refresh on 401 Unauthorized

Mi

Band

/

MIUI

Health

Steps,  sleep  (manual  export

Xiaomi

Export

only)

Import via share sheet JSON

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 159

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 35
A/B Testing & Feature Flags

RemoteConfig · Experiments · Rollouts

35.1 Feature Flag Architecture

All  feature  flags  are  stored  in  the  Appwrite  remote_config  collection  and  fetched  on  app  foreground.  The

last-fetched config is persisted in Drift so flags work offline.

// lib/core/config/remote_config.dart
@riverpod
class RemoteConfigNotifier extends _$RemoteConfigNotifier {
  @override
  Future<RemoteConfig> build() async {
    final cached = await ref.read(databaseProvider).remoteConfigDao.getAll();
    // Return cached immediately, then refresh in background
    _scheduleRefresh();
    return RemoteConfig.fromMap(cached);
  }

  Future<void> _scheduleRefresh() async {
    if (!await ref.read(connectivityProvider.future)) return;
    final fresh = await ref.read(databaseProvider.notifier).fetchRemoteConfig();
    state = AsyncData(fresh);
  }
}

// Usage anywhere in widget tree:
final showAiScanner = ref.watch(remoteConfigProvider).value?.aiScannerEnabled ?? true;
if (showAiScanner) ... // feature rendered or hidden

35.2 Current A/B Experiments

Experiment

Variants

Metric

Status

Dashboard layout

Bento vs. List

Day-30 retention

Running (50/50)

Pro pricing

n99 vs n79/mo

Conversion rate

Running (50/50)

Onboarding length

5 screens vs 3 screens

Completion rate

Karma animation

XP float vs confetti

Daily DAU

Food log nudge

Push at 13:00 vs 12:30

Lunch log rate

Completed

(5-screen

wins)

Running (25/75 toward

confetti)

Completed

(13:00

wins)

AI scanner CTA

Orange vs purple button

Scan attempt rate

Running (50/50)

Streak reminder

20:00 vs 19:00

Streak rescue rate

Completed

(20:00

wins)

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 160

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Appwrite Console + Internal Admin Tool

§ 36
Admin Dashboard

36.1 Admin Capabilities

Capability

Tool

Access Level

User search (by phone/name)

Internal admin Flutter app

Admin role only

Subscription management

Razorpay + Appwrite admin

Admin role

Feature flag update

Push notification broadcast

Appwrite

Console

remote_config

Admin role

Appwrite

broadcastNotif

Function:

Admin role

DLQ monitoring

Internal dashboard

Admin + Support

Crash reports

Sentry web dashboard

Engineering

Performance traces

Sentry Performance tab

Engineering

Database inspection

Appwrite Console

Admin role

Storage management

Appwrite Storage Console

Admin role

Backup status

Appwrite

console

+

B2

dashboard

Admin role

A/B experiment control

RemoteConfig collection update

Product + Engineering

Content moderation

Feed  reports  queue  in  admin

app

Support team

Revenue metrics

Razorpay Dashboard

Finance + Product

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 161

ﬁ
FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 37
Data Export & GDPR

Right to Export · Right to Erasure · Audit Log

37.1 Data Export Format
Users can request a full data export from Settings ﬁ Privacy ﬁ Export My Data. The export is generated by an
Appwrite Function and delivered as a downloadable JSON zip within 60 seconds for typical accounts.

{
  "export_version": "2.0",
  "generated_at": "2025-10-01T10:00:00Z",
  "user_id": "abc123",
  "name": "Rahul Sharma",
  "food_logs": [...],
  "step_logs": [...],
  "sleep_logs": [...],
  "water_logs": [...],
  "bp_logs": [...],
  "glucose_logs": [...],
  "mood_logs": [...],       // decrypted inline (user's own key)
  "journal_entries": [...], // decrypted inline
  "period_logs": [...],     // decrypted inline
  "workout_sessions": [...],
  "achievements": [...],
  "karma_history": [...],
  "preferences": {...},
  "abha_links": [...]       // IDs only — no health records cloned
}

37.2 Right to Erasure

// Deletion flow (Settings ﬁ Privacy ﬁ Delete Account)
// Step 1: User confirms with phone OTP
// Step 2: Appwrite Function: deleteUserData
//   - Delete all collections documents where user_id == uid
//   - Delete profile from users collection
//   - Delete Appwrite Storage media
//   - Delete Appwrite account (terminates all sessions)
//   - Delete FCM token from Appwrite
//   - Queue Razorpay subscription cancellation
// Step 3: Local cleanup
//   - Drop Drift database file
//   - Clear flutter_secure_storage
//   - Clear shared_preferences
//   - Logout ﬁ /auth/login

// Retention: Anonymized aggregate stats (no user_id) retained 90 days
// ABHA data: Not stored by FitKarma — lives in NHA. No deletion action needed.

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 162

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

1000+ Indian Recipes · Scaling · Meal Planning

§ 38
Recipe Engine

38.1 Recipe Data Model

{
  "id": "dal_makhani_001",
  "name_en": "Dal Makhani",
  "name_hi": "nnn nnnn",
  "region": "punjabi",
  "meal_types": ["lunch", "dinner"],
  "tags": ["vegetarian", "high_protein", "gluten_free"],
  "dosha_effects": {"vata": "decreases", "pitta": "neutral", "kapha": "increases"},
  "prep_time_min": 20,
  "cook_time_min": 45,
  "servings": 4,
  "ingredients": [
    {"name_en": "Black Lentils", "name_hi": "nnnn nnn", "amount_g": 200, "unit": "g"},
    {"name_en": "Ghee", "name_hi": "nn", "amount_g": 30, "unit": "g"},
    ...
  ],
  "steps": ["Soak lentils 8h", "Pressure cook 20 min", "Temper in ghee", ...],
  "nutrition_per_serving": {
    "kcal": 420, "protein_g": 18, "carbs_g": 52, "fat_g": 16, "fibre_g": 9
  },
  "difficulty": "medium",
  "source": "bundled_v2"
}

38.2 Ingredient Scaling Algorithm

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 163

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

// lib/features/nutrition/domain/recipe_scaler.dart
class RecipeScaler {
  Recipe scale(Recipe original, int newServings) {
    final ratio = newServings / original.servings;
    return original.copyWith(
      servings: newServings,
      ingredients: original.ingredients.map((ing) => ing.copyWith(
        amount: _smartRound(ing.amount * ratio, ing.unit),
      )).toList(),
      // Nutrition scales linearly
      nutritionPerServing: original.nutritionPerServing, // per serving unchanged
    );
  }

  // Smart rounding: 0.5 tsp ﬁ 1/2 tsp (not 0.5), 1.5 cups ﬁ 1½ cups
  String _smartRound(double amount, String unit) {
    if (unit == 'g' || unit == 'ml') return amount.round().toString();
    final fractions = {0.25: '¼', 0.5: '½', 0.75: '¾', 1/3: 'n', 2/3: 'n'};
    final whole = amount.floor();
    final frac = amount - whole;
    final fracStr = fractions.entries
      .firstWhere((e) => (e.key - frac).abs() < 0.05, orElse: () => MapEntry(frac, ''))
      .value;
    return whole > 0 ? '$whole$fracStr' : fracStr;
  }
}

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 164

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 39
Performance Deep-Dive

Profiling · Benchmarks · Memory

39.1 Flutter Performance Checklist

Check

Implementation

Verified By

const constructors on all stateless

Enforced

by

flutter_lints

widgets

const_constructor

CI lint check

RepaintBoundary on activity rings

Wraps each AnimatedRing

DevTools layer count

Shimmer only on remote content

Shimmer.fromColors  only  in  network

widgets

Code review

ListView.builder not ListView

All lists use builder constructor

Code review

Image caching

CachedNetworkImage everywhere

Network tab check

Drift FTS5 for food search

MATCH  operator  on

food_items

table

Benchmark: < 50ms

Isolate for sync engine

Workmanager background isolate

DevTools timeline

Lazy provider disposal

ref.onDispose on all FamilyProviders Memory profiler

No build() in setState

Zero  StatefulWidgets

in

feature

screens

Code review

Frame budget monitoring

FlutterError.onError ﬁ Sentry

Sentry Perf dashboard

Dart VM profile mode CI

flutter build --profile APK in CI

CI artefact check

39.2 Memory Targets

Screen

RSS Target

Notes

Dashboard (loaded)

< 180 MB

3 ring animations + bento grid

Food search (open)

< 220 MB

5,000 item list in memory

Active workout

< 150 MB

Timer + video player

Sleep screen

< 120 MB

Chart + moon animation

Social feed (20 posts)

< 200 MB

CachedNetworkImage + Riverpod

Background

(all

screens

destroyed)

< 60 MB

SyncEngine isolate only

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 165

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 40
Localization & Bilingual UI

40.1 Supported Languages

22 Languages · ARB Files · RTL

en

hi

bn

te

ta

mr

gu

kn

ml

pa

ur

or

as

sd

ks

mni

mai

sat

bho

raj

Code

Language

English

Hindi

Script

Latin

Devanagari

Bengali

Bengali

Telugu

Tamil

Marathi

Gujarati

Telugu

Tamil

Devanagari

Gujarati

Kannada

Kannada

Malayalam

Malayalam

Punjabi

Gurmukhi

Urdu

Odia

Odia

Assamese

Assamese

Manipuri

Meitei Mayek

Maithili

Santali

Devanagari

Ol Chiki

Bhojpuri

Devanagari

Rajasthani

Devanagari

awa

Awadhi

Devanagari

doi

Dogri

Devanagari

RTL

Status

No

No

No

No

No

No

No

No

No

No

Complete (default)

Complete

Complete

Complete

Complete

Complete

Complete

Complete

Complete

Complete

No

No

Beta

Beta

No

No

No

No

No

No

No

Planned

Planned

Planned

Beta

Beta

Planned

Planned

Nastaliq

Yes

Complete

Sindhi

Arabic

Yes

Planned

Kashmiri

Perso-Arabic

Yes

Planned

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 166

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

40.2 Bilingual Labelling Strategy

Not  every  UI  element  is  bilingual  —  this  would  clutter  the  interface.  The  strategy  is  surgical:  high-information

labels and navigation get bilingual treatment, while buttons, system messages, and dynamic content stay in the

selected language only.

Element

Bilingual?

Example

Bottom nav labels

Screen titles

Section headings

Yes

Yes

Yes

Home / nnn

Food Log / nnnn nn nnn

Today's Activity / nn nn nnnnnnn

Food item names

Yes (in DB)

Dal Rice / nnn nnnn

Metric labels

Button labels

Error messages

Notification text

Legal/Terms

Yes (micro)

Steps / nnn next to value

No

No

No

No

Log Meal (selected language only)

Selected language only

Selected language only

English + Hindi (separate docs)

Karma level titles

Yes

Warrior / nnnnnn

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 167

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 41
WhatsApp Bot Technical Spec

Intent · NLU · Appwrite Function · Privacy

41.1 Bot Architecture

// WhatsApp ﬁ Twilio / Infobip webhook ﬁ Appwrite Function: whatsappBot
// Appwrite Function receives POST with message body

async function whatsappBot(req, res) {
  const { from, body } = JSON.parse(req.body);

  // 1. Verify user mapping (WhatsApp number ﬁ FitKarma user)
  const user = await databases.listDocuments('fitkarma_db', 'wa_link', [
    Query.equal('wa_number', from)
  ]);
  if (!user.documents.length) {
    return sendReply(from, 'Please link your WhatsApp in the FitKarma app first.');
  }

  // 2. Parse intent via Claude API (short prompt)
  const intent = await parseIntent(body, user.documents[0].language);

  // 3. Execute action
  switch (intent.type) {
    case 'LOG_FOOD':  await logFood(user, intent); break;
    case 'LOG_WATER': await logWater(user, intent); break;
    case 'GET_STEPS': await getSteps(user, intent); break;
    case 'GET_SUMMARY': await getSummary(user, intent); break;
    default: sendReply(from, helpMessage(user.language));
  }
}

41.2 Supported Commands

Example Message

Parsed Intent

Action

"Had dal rice for lunch"

LOG_FOOD:  dal_rice,

lunch

Log 1 serving dal rice as lunch

"Drank 2 glasses of water"

LOG_WATER: 400ml

Log 400ml water

"Drank ek bottle paani"

LOG_WATER: 1000ml

Hindi parsed, 1 bottle = 1000ml

"What

are  my

steps

today?"

"Kal kitne kadam chale?"

"Show my summary"

GET_STEPS: today

Reply with today's step count

GET_STEPS:

yesterday

GET_SUMMARY:

today

Hindi — yesterday's steps

Reply with food+steps+water summary

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 168

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Example Message

Parsed Intent

Action

"Had poha naashte mein"

LOG_FOOD:

poha,

breakfast

Hindi + English mixed

"2 roti with dal for dinner"

LOG_FOOD:  roti  x2  +

dal, dinner

Multi-item parsing

"Bhul gaya log karna"

HELP

'Forgot to log' ﬁ help message

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 169

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 42
Pregnancy Tracker Module

Week-by-Week · Nutrition · Exercise

42.1 Module Overview

The  Pregnancy  Tracker  module  provides  week-by-week  guidance,  calorie  adjustments,  safe  exercise

recommendations,  and  symptom  tracking  for  expecting  mothers.  All  data  is  encrypted  using  the  HKDF

reproductive key class.

Feature

Details

Week tracker

Current week (1–40), trimester, key milestones

Baby size visual

Fruit/vegetable size comparison (mango, papaya, etc.)

Nutrition goals

Trimester-adjusted: +200/300/450 kcal, iron/folate/DHA targets

Food safety

Foods to avoid (papaya, raw eggs, high-mercury fish) — Indian context

Safe exercise

First trimester: walks, yoga. Second: swimming. Third: pelvic floor

Symptom log

Morning sickness, fatigue, heartburn, swelling with remedies

Doctor visits

Scheduled checkup reminders with checklists

Weight gain

WHO chart overlay with personalized guidance

Kick counter

Baby movement tracker from week 28

Birth plan

Template builder shareable as PDF with hospital

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 170

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Multi-Profile · Dependent Management · Emergency

§ 43
Family Health Module

43.1 Family Profiles

Up to 5 family members can be managed from one FitKarma account. Each profile has independent health data,

goals, and medication schedules. The primary user can toggle between profiles from the Profile screen.

Feature

Description

Add member

Name, age, gender, medical conditions, medications

Switch profile

Tap avatar ﬁ select member (fast profile switch)

Age-appropriate UI

Child mode (6–12): simplified UI, no BP/glucose logging

Elderly mode

Larger text, simpler navigation, daily vitals focus

Shared challenges

Family step challenge: combined steps count

Medical summary

PDF health summary per family member for doctor visits

Emergency contacts

Aadhaar-linked ICE (In Case of Emergency) contacts

Medication alerts

BP/glucose threshold alerts sent to primary user

BP inheritance risk

If both parents log hypertension, child BP tracking suggested

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 171

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ 44
Product Roadmap

Q1–Q4 2026 Planned Features

Quarter

Feature

Effort

Priority

Q1 2026

Q1 2026

Q1 2026

CGM

(Continuous  Glucose  Monitor)

integration via Libre API

Teleconsultation:  in-app  doctor  video  via

Jitsi

L

L

P0 — Diabetes management

P0 — Primary care access

Bharat

health

insurance

integration

(PM-JAY eligibility check)

M

P1

Q1 2026

Offline voice assistant (on-device Whisper)

L

P1 — Rural accessibility

Q2 2026

Q2 2026

Q2 2026

Q2 2026

Q3 2026

Q3 2026

Q3 2026

Q3 2026

Q4 2026

Q4 2026

Q4 2026

ECG  reader  via  smartwatch  (Apple  Watch

Series 4+)

M

P0 — Heart health

Diet  counsellor  AI  (fine-tuned  on  Indian

dietary guidelines)

XL

P0 — Nutrition upgrade

Group  workout  sessions  (screen  share  +

sync timer)

Hospital  discharge  summary  OCR  +  care

plan generator

M

L

P2

P1

Rural  health  worker  (ASHA)  mode  with

patient management

XL

P0 — Rural India

Ayushman  Bharat  Digital  Mission

full

integration

Mental

health

peer-support

groups

(moderated)

Postpartum

care

module

(90-day

post-delivery tracking)

L

M

M

P0 — Government mandate

P1

P2

FitKarma  for  Diabetes  (dedicated  chronic

disease app)

XL

P0 — New vertical

AI  fitness  coach  with  personalized  video

plans

Wearable-based  stress  detection

(HRV

analysis)

XL

P1

M

P1

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 172

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Quarter

Feature

Effort

Priority

Q4 2026

Smart  home  device  integration  (Mi  Smart

Scale, BP monitor BT)

L

P2

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 173

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Technical Terms · Domain Terms · Abbreviations

§ 45
Glossary

45.1 Technical Glossary

Term

Definition

AES-256-GCM

Advanced  Encryption  Standard,  256-bit  key,  Galois/Counter  Mode  —

authenticated encryption used for all sensitive FitKarma data

HKDF

Drift

SQLCipher

Riverpod

Appwrite

GoRouter

HMAC-based Key Derivation Function — derives per-class encryption keys from a

master key

Dart  ORM  for  SQLite  with  type-safety  and  code  generation.  Uses  SQLCipher  for

encryption.

Open-source SQLite extension that provides transparent 256-bit AES encryption of

database files.

Reactive caching and dependency injection framework for Flutter. Version 2.x with

code generation.

Open-source Backend-as-a-Service providing Auth, Database, Storage, Functions,

and Realtime.

Flutter  navigation  package  with  declarative  routes,  deep-linking,  and  URL-based

navigation.

Dead

Letter  Queue

(DLQ)

Queue of sync operations that have failed 5+ times. Requires manual review.

Idempotency key

Version vector

TDEE

Bento grid

Glassmorphism

Rive

UUID  v4  assigned  to  each  write  operation  ensuring  safe  retries  without  duplicate

data.

Per-field  versioning  system  used  in  sync  conflict  resolution  —  selects  higher

version per field.

Total Daily Energy Expenditure — calculated from BMR × activity multiplier, used

for calorie goals.

Layout  pattern  using  cards  of  varied  sizes  (1/3,  2/3,  full-width)  arranged  in  a

responsive grid.

UI  style  with  frosted-glass  effect  using  BackdropFilter  blur  and  semi-transparent

surfaces.

Real-time animation platform for Flutter supporting state machines and interactive

animations.

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 174

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Term

Lottie

MET

FTS5

RepaintBoundary

FCM

WorkManager

Definition

Adobe After Effects animations exported as JSON and rendered natively in Flutter.

Metabolic Equivalent of Task — unit to estimate calorie burn from physical activity.

Full-Text Search extension for SQLite — enables fast keyword search across large

text corpora.

Flutter  widget  that  isolates  subtree  repaints,  preventing  expensive  widgets  from

triggering parent repaints.

Firebase Cloud Messaging — Google's push notification delivery service. Used for

token delivery only.

Background task scheduler for Flutter, backed by Android WorkManager and iOS

BGTaskScheduler.

45.2 Domain Glossary

Term

Definition

ABHA

NHA

Ayushman  Bharat  Health  Account  —  India's  national  digital  health  ID,  14-digit  identifier

managed by NHA.

National  Health  Authority  —  government  body  managing  ABHA  and  Ayushman  Bharat

Digital Mission.

ABPM

Ambulatory Blood Pressure Monitoring — 24-hour BP measurement worn as a device.

HbA1c

BMR

Glycated  haemoglobin  —  3-month  average  blood  glucose  indicator,  used  for  diabetes

monitoring.

Basal  Metabolic  Rate  —  calories  burned  at  rest,  calculated  via  Mifflin-St  Jeor  equation  in

FitKarma.

Dosha

Ayurvedic constitutional type — Vata (air/space), Pitta (fire/water), Kapha (earth/water).

Ritucharya

Dincharya

PHQ-9

GAD-7

ASHA

Ayurvedic  seasonal  routine  —  6  seasons  in  a  year  with  specific  dietary  and  lifestyle

guidance.

Ayurvedic  daily  routine  —  personalized  morning  and  evening  practices  for  health

optimization.

Patient Health Questionnaire-9 — validated 9-question depression screening tool.

Generalized Anxiety Disorder 7-item scale — validated anxiety screening questionnaire.

Accredited Social Health Activist — frontline community health workers in India's rural health

system.

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 175

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Term

Definition

PM-JAY

Pradhan  Mantri  Jan  Arogya  Yojana  —  India's  national  health  insurance  scheme  (n5  lakh
cover).

CGM

SpO2

Karma

ICE

Continuous Glucose Monitor — wearable device for real-time blood glucose monitoring (e.g.

FreeStyle Libre).

Peripheral oxygen saturation — percentage of haemoglobin carrying oxygen, measured by

pulse oximetry.

FitKarma's  gamification  currency.  Points  awarded  for  healthy  behaviors,  levels  up  with  XP

milestones.

In  Case  of  Emergency  —  emergency  contacts  linked  to  a  user's  profile  for  health

emergencies.

45.3 Abbreviations Index

Abbr

Abbr

API

Expansion

Expansion

Abbr

Expansion

IST

Indian Standard Time (UTC+5:30)

Application

Programming

Interface

JSON

JavaScript Object Notation

APK

Android Package Kit

JWT

JSON Web Token

ARB

Application  Resource  Bundle

(localization)

MCP

Model Context Protocol

BLE

Bluetooth Low Energy

ORM

Object-Relational Mapping

CI/CD

Continuous

Integration

/

Continuous Deployment

OTP

One-Time Password

DAO

Data Access Object

PKCE

Proof Key for Code Exchange

DI

DLQ

E2E

Dependency Injection

Dead Letter Queue

End-to-End

SDK

SHA

SQL

Software Development Kit

Secure Hash Algorithm

Structured Query Language

FCM

Firebase Cloud Messaging

SQLite

Self-contained,

serverless  SQL  database

engine

FTS

Full-Text Search

TTL

Time To Live

GDPR

General

Data

Protection

Regulation

UI

User Interface

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 176

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Abbr

Expansion

Abbr

Expansion

HTTP

Hypertext Transfer Protocol

UUID

Universally Unique Identifier

HTTPS

HTTP Secure

UX

User Experience

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 177

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

§ UI+
Extended Screen Gallery

Glucose & SpO2 Monitoring

Additional Annotated Mockups

Blood Glucose

98

mg/dL  ·  Fasting  ·  07:30

Normal

Fasting

Post-Meal

HbA1c

30-day Glucose

5.4%

HbA1c  ·  3-month avg  ·  Normal

n

Meditation
nnnnn

Breathe
n
Inhale 4s

n

n

Pause

Skip

Sound

12:45

Time remaining

Figure UI-13 · Glucose scatter chart with HbA1c card · Meditation breathing circle with timer

Blood Glucose Tracker

Meditation & Breathing

Ayurveda Hub & Recipe Engine

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 178

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Ayurveda Hub
nnnnnnnn

Recipes
nnnnnn

Your Dosha Profile

Vata

Pitta

Kapha

35%

45%

20%

Recommended Herbs
n Ashwagandha
Stress, immunity

n Triphala

Digestion, detox

n Turmeric

Anti-inflammatory

All

Veg

Quick

Vata

n Dal Makhani

Punjabi · 65 min

420 kcal

n Poha

Maharashtra · 20 min

280 kcal

n Idli Sambar

South Indian · 40 min

210 kcal

n Palak Paneer

North Indian · 30 min

380 kcal

Figure UI-14 · Ayurveda dosha profile with herb cards · Recipe library with filter chips

Recipe Engine

Ayurveda Hub

Medication Tracker & Lab Reports Detail

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 179

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Medications
nnnnnnn

92%

30-day Adherence  ·  Excellent

Today

n Metformin 500mg

08:00

n Amlodipine 5mg

08:00

n Atorvastatin 20mg

22:00

n Vitamin D3
Anytime

Taken

Taken

Due

Due

Figure UI-15 · Medication tracker: 92% adherence ring, daily schedule with taken/due status
Medication Tracker

Light Mode — Warm Parchment Theme

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 180

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

FitKarma
Namaste, Rahul n

R

1,247

Karma Points  (cid:127)  Level 8

82%

61%

45%

7,842

Steps  / 10K

1.8L

Water  / 2.5L

n

n

n

n

n

Home

Food

Workout

Health

Profile

Food Log
nn nn nnnn

1,840

kcal  /  2200 goal

Carbs

Protein

Fat

Breakfast  n
Poha, Tea

Lunch  nn
Dal Rice, Raita

Snack  nn
Fruits, Chai

412 kcal

680 kcal

220 kcal+

Figure UI-16 · Light mode warm parchment theme — Dashboard and Food Log in LBG0 (#F7F0E8) background

Dashboard (Light Mode)

Food Log (Light Mode)

Challenges & Leaderboard Detail

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 181

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

October Steps

n
8,432 participants
Ends Oct 31  ·  Step Challenge

Your rank: #234  (cid:127)  6,834 steps

Milestone Rewards

100,000 steps

Completion badge3

200,000 steps

500 XP bonus—

300,000 steps

Exclusive title—

Top Participants

n  Priya S

n  Amit K

12,450

11,820

Figure UI-17 · Challenge detail: hero with participant count, milestone rewards, leaderboard
Challenge Detail Screen

10,930

n  Meera

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 182

‹
FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Design Tokens — Complete Reference

The  following  table  lists  every  design  token  used  in  FitKarma's  theming  system.  Tokens  are  defined  in

lib/core/constants/app_tokens.dart and consumed via AppTokens.primary, AppTokens.surface1, etc.

Token Name

Dark Hex

Light Hex

Usage

bg0

bg1

bg2

surface0

surface1

surface2

divider

primary

#080810

#F7F0E8

Deepest background layer

#0F0F1A

#FDF6EC

Primary scaffold background

#161625

#F0E8DC

Secondary screen background

#1C1C2E

#FFFFFF

Base card surface

#22223A

#FFF8F0

Elevated cards

#2A2A45

#F5EDE0

Tooltips, pop-overs

#2A2A50

#E8D8C8

Borders, separators

#FF6B35

#F4511E

Main CTAs, active states

primaryMuted

#3D1500

#FEE8E2

Primary tinted surfaces

accent

#FFB547

#F59E0B

Karma, streaks, highlights

accentMuted

#3A2800

#FEF3C7

Accent tinted surfaces

secondary

#7B6FF0

#5B50D4

Hero accents, badges

secondaryMuted

#1E1848

#EDE9FE

Secondary tinted surfaces

teal

#00D4B4

#0D9488

Water, Ayurveda, SpO2

tealMuted

#001A14

#CCFBF1

Teal tinted surfaces

success

#4ADE80

#22C55E

Healthy states, completed

successMuted

#0D2218

#DCFCE7

Success tinted surfaces

warning

#FBBF24

#D97706

Elevated readings, caution

error

rose

purple

#F87171

#EF4444

Critical readings, destructive

#FB7185

#E11D48

Period tracker accent

#C084FC

#9333EA

Active minutes ring

textPrimary

#F1F0FF

#1A1830

Main body text

textSecondary

#9B99CC

#6B6A96

Labels, subtitles

textMuted

#6B68A0

#9CA3AF

Placeholders, decorative

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 183

FitKarma — Developer & UI Documentation

India's Offline-First Fitness Platform

Documentation Complete

This  documentation  covers  the  complete  FitKarma  2.0  engineering  and  UI  specification  across  150  pages.  It

includes  architecture,  database  schemas,  Riverpod  provider  catalogue,  GoRouter  navigation,  all  45+  screen

specs,  UI  component  library,  security  model,  integration  guide,  testing  strategy,  CI/CD  pipeline,  and  the

complete screen gallery with annotated mockups.

Repository & Resources

Source code: github.com/fitkarma/fitkarma-app Appwrite console: cloud.appwrite.io/console/fitkarma_prod Sentry

dashboard: sentry.io/organizations/fitkarma Razorpay dashboard: dashboard.razorpay.com Figma design:

figma.com/file/fitkarma-v2-design Internal admin: admin.fitkarma.in (VPN required) Backblaze B2:

app.backblazeb2.com/buckets/fitkarma-backups

Contact & Support

Engineering Lead: engineering@fitkarma.in Design Lead: design@fitkarma.in Product: product@fitkarma.in Privacy/Legal:

privacy@fitkarma.in Crash/Ops: ops@fitkarma.in

Flutter 3.x  ·  Riverpod 2.x  ·  Drift (SQLCipher)  ·  Appwrite  ·  Built for India

Page 184

