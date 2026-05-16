Deployment steps (recommended for assignment submission)

Option A — Build frontend locally and deploy Docker image that copies `public/build` (recommended)
1. On your development machine, install Node.js and PHP tooling.
2. Build frontend assets locally:

PowerShell (Windows):

```powershell
npm ci
npm run build
```

Bash (Linux/macOS):

```bash
npm ci
npm run build
```

3. Verify `public/build` exists.
4. Build Docker image using `Dockerfile.prod` (this Dockerfile expects `public/build` already present in the repo directory):

```bash
docker build -f Dockerfile.prod -t from-my-stove-to-yours:prod .
```

5. Push image to your registry (Docker Hub, Render's container registry, etc.) or deploy to Render by connecting the repository (ensure `public/build` is committed or available in build context).

Option B — Build in CI (if your host supports Node builds in the Dockerfile)
- Use the main `Dockerfile` that includes a frontend stage. If CI still fails with native module errors, prefer Option A or use a host that supports full Node builds.

Notes
- `Dockerfile.prod` does not run `npm run build`; it installs PHP deps and copies your app code. This avoids build failures caused by missing build tools in remote CI.
- If you prefer CI builds, adjust the frontend stage to use `node:20-bullseye` and ensure `build-essential`/`python3` are installed (already present in `Dockerfile`).

Troubleshooting
- If Render still fails, capture the full `npm run build` error output and open an issue here (paste the log). If you want, I can help craft a CI-friendly Dockerfile for Render specifically.
