# Home

<h1 align="center">Hi there, I'm Atticus Zeller (周宙) 🤖</h1>

<h3 align="center">Embodied AI Researcher & VLA Algorithm Engineer</h3>

<p align="center">
  <a href="https://docs.atticux.me">Blog / Docs</a> •
  <a href="mailto:hello@atticux.me">Email</a> •
  <a href="https://orcid.org/0009-0008-5460-325X">ORCID</a>
</p>

---

I am currently a Master's student in Artificial Intelligence at Shanghai Normal University. My research and engineering efforts are heavily focused on __Vision-Language-Action (VLA) models__ and __Reinforcement Learning__ for physical robotic manipulation. I bridge the gap between open-world semantic understanding and contact-rich precision control.

## 🔭 Current Focus

- __VLA Deployment:__ Fine-tuning and deploying state-of-the-art VLA models (`SmolVLA`, `π0.5`) on the __SO-ARM101__ bimanual robot.
- __RL for Robotics:__ Implementing residual online Reinforcement Learning (e.g., _RL Token_) to decouple high-level reasoning from low-level muscle reflexes.
- __Hardware-Software Co-design:__ Optimizing 50Hz control loops via Client-Server async inference architectures and addressing Sim-to-Real gaps using __Isaac Lab__ / __MuJoCo__.

## 🛠️ Tech Stack

- __Embodied AI & Robotics:__ LeRobot | SO-ARM101 | Action Chunking | Flow Matching | Sim2Real
- __Reinforcement Learning:__ TD3 | PPO | Behavior Cloning (BC) | DAgger | Residual RL
- __Deep Learning:__ PyTorch | HuggingFace | CUDA | 3D Gaussian Splatting
- __Simulation:__ MuJoCo | Isaac Lab / Isaac Sim
- __DevOps & Backend:__ Linux | Docker | FastAPI | Git | Claude Agentic Workflow

## 📦 Selected Open Source & Research

- 📄 __[GSplatLoc: Ultra-Precise Camera Localization via 3D Gaussian Splatting](https://arxiv.org/abs/2412.20056)__ (1st Author)
  - Formulated camera pose estimation as a gradient optimization problem to minimize translation and rotation errors in high-resolution 3DGS environments.
- 🦾 __LeRobot (VLA Pipeline SOPs)__
  - Maintaining comprehensive Chinese engineering docs for `SO-ARM101 × VLA`. Covering data collection, 3D-2D mask projection filtering, LoRA fine-tuning, and asynchronous inference loops.
- ⚡ __[fastapi-supabase-template](https://github.com/AtticusZeller/fastapi-supabase-template)__
  - A highly concurrent async backend scaffolding boilerplate, deeply integrated with Docker and built via agentic workflows.

<p align="center">
  <i>"Replacing pure imitation with physical reflexes."</i>
</p>
