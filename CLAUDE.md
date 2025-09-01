# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

- `bin/rails server` - Start the Rails development server
- `bin/rails console` - Open Rails console  
- `bin/rails test` - Run all tests
- `bin/rails test:db` - Reset database and run tests
- `bin/rails db:create` - Create database
- `bin/rails db:migrate` - Run database migrations
- `bin/rails db:seed` - Seed the database with sample data
- `bundle exec rubocop` - Run Ruby linting
- `bundle install` - Install gem dependencies

## Architecture Overview

This is a Ruby on Rails 7.1+ fitness social platform called AIFitAssist that connects users for sports activities. The app uses:

- **Authentication**: Devise for user authentication
- **Database**: PostgreSQL with Active Record
- **Frontend**: Hotwire (Turbo + Stimulus) with Bootstrap 5
- **File Storage**: Active Storage with Cloudinary
- **AI Integration**: RubyLLM for chat features and user embeddings
- **Location**: Geocoder for location-based features
- **Vector Search**: Neighbor gem for user similarity matching

### Key Models & Relationships

- **User**: Central model with Devise authentication, has avatar, location (geocoded), sports preferences, age range, and vector embeddings for matching
- **Post**: Social media posts with images, likes, and comments
- **Event**: Sports events that users can participate in
- **Conversation**: AI or human-to-human chat conversations with automatic title generation
- **Message**: Chat messages within conversations with role-based content (user/assistant)
- **Match**: User matching system for finding compatible sports partners

### Core Features

1. **Social Feed**: Users can create posts, like, and comment (similar to social media)
2. **AI Chat Assistant**: Conversations with AI for sports advice and event planning
3. **Event Creation**: AI can generate sports events from conversation context when time/date detected
4. **User Matching**: Vector similarity matching based on sports preferences and age
5. **Location-based Discovery**: Find nearby users and events
6. **Human-to-Human Messaging**: Direct messaging between users

### Frontend Architecture

- Uses Stimulus controllers for JavaScript interactivity
- Bootstrap 5 with custom SCSS organization in `app/assets/stylesheets/`
- Turbo streams for real-time updates (likes, comments, messages)
- Location detection via JavaScript geolocation API

### Database Schema Notes

- Users have vector embeddings updated automatically when sports/profile changes
- Events support both string and datetime for start/end times (with parsing logic)
- Conversations can be AI-only or between two users
- Messages have roles ("user" or "assistant") for AI chat context

### Key Controllers

- `PostsController`: Social feed functionality
- `ConversationsController`: AI chat and human messaging
- `EventsController`: Sports event management
- `DashboardsController`: Main dashboard with weather, nearby users, events
- `MessagesController`: Handle chat message creation with AI responses

The application emphasizes real-time interactivity, location awareness, and AI-powered features for sports community building.