#!/bin/bash

# 📌 Konfiguracja
PROJECT_ID="flyagaricfr"
REGION_ARTIFACT="europe-west9"     # Region Artifact Registry (np. Paryż)
REGION_CLOUDRUN="europe-west1"     # Region Cloud Run (np. Belgia)
REPO_NAME="medusa-repo"
IMAGE_NAME="medusa-backend"
SERVICE_NAME="flyagaricfr"         # Nazwa usługi Cloud Run
TAG="latest"

# 🖼️ Pełna ścieżka obrazu
IMAGE_URI="$REGION_ARTIFACT-docker.pkg.dev/$PROJECT_ID/$REPO_NAME/$IMAGE_NAME:$TAG"

echo "🔧 Buduję obraz Dockera..."
docker build -t "$IMAGE_URI" .

echo "📤 Wysyłam obraz do Artifact Registry..."
docker push "$IMAGE_URI"

echo "☁️ Wdrażam usługę do Cloud Run..."
gcloud run deploy "$SERVICE_NAME" \
  --image "$IMAGE_URI" \
  --platform managed \
  --region "$REGION_CLOUDRUN" \
  --allow-unauthenticated \
  --memory 512Mi \
  --port 8080 \
  --project "$PROJECT_ID"

echo "✅ Gotowe! Usługa '$SERVICE_NAME' została wdrożona w Cloud Run."
