# Setup Instructions

## 🚀 Quick Setup for Development

### 1. Clone the Repository
```bash
git clone https://github.com/0xmarblemaster/chess-learning-platform-rag.git
cd chess-learning-platform-rag
```

### 2. Environment Configuration
```bash
# Copy the environment template
cp .env.example .env

# Edit .env with your API keys:
# OPENAI_API_KEY=your_openai_api_key_here
# ELEVEN_API_KEY=your_elevenlabs_api_key_here (optional)
```

### 3. Backend Setup
```bash
# Create virtual environment
python -m venv backend/venv_local
source backend/venv_local/bin/activate  # Linux/Mac
# or
backend\venv_local\Scripts\activate  # Windows

# Install dependencies
pip install -r backend/requirements.txt

# Start backend
python -m backend.app
# ✅ Backend running on http://localhost:5001
```

### 4. Test FEN Search (Verify Working)
```bash
# Test the core functionality
python test_user_fen.py
# Should output: "Found 5 results" for test FEN

# Test API endpoint
curl -X POST http://localhost:5001/api/chat/rag \
  -H "Content-Type: application/json" \
  -d '{
    "query": "search games r1bqkbnr/pppp1ppp/2n5/4p3/3PP3/5N2/PPP2PPP/RNBQKB1R b KQkq - 0 3",
    "session_id": "test_session",
    "fen": "r1bqkbnr/pppp1ppp/2n5/4p3/3PP3/5N2/PPP2PPP/RNBQKB1R b KQkq - 0 3"
  }'
```

### 5. Docker Setup (Alternative)
```bash
# Start all services with Docker
docker compose up --build -d

# Services will be available at:
# - Backend: http://localhost:5001
# - Frontend: http://localhost:3000
# - Weaviate: http://localhost:8080
```

## 🏗️ Project Structure
```
chess-learning-platform-rag/
├── backend/                 # Python Flask backend
│   ├── etl/                # ETL pipeline and agents
│   │   └── agents/         # RAG agents (retriever, answer, etc.)
│   ├── app.py              # Main Flask application
│   └── requirements.txt    # Python dependencies
├── frontend/               # React/TypeScript frontend
├── docker-compose.yml      # Development environment
├── Dockerfile             # Backend containerization
├── .env.example           # Environment configuration template
└── FEN_SEARCH_FIX_SUMMARY.md  # Recent critical fix documentation
```

## ✅ Current Working Features
- **FEN Position Search**: Search games by chess position (FULLY WORKING)
- **Chess Game Database**: 6,428 games loaded and searchable
- **Advanced RAG System**: Context-aware retrieval and response generation
- **Stockfish Integration**: Chess engine analysis
- **OpenAI Integration**: LLM-powered responses
- **Weaviate Database**: Vector search capabilities

## 🔧 Recent Major Fix
- **FEN Search Restored**: Fixed `OPENING_BOOK_PATH` import error
- **Enhanced Retriever**: Improved fallback logic for game detection
- **100% Success Rate**: All FEN position searches now work perfectly

See `FEN_SEARCH_FIX_SUMMARY.md` for complete technical details.

---

**Ready to develop! The platform is fully operational with working FEN search capabilities.**