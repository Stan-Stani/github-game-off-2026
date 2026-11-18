# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Ground rule: do not change anything unless explicitly asked

This is a for-fun project for learning's sake. **Do not edit, create, or delete files, or run commands that change state, unless the user explicitly asks.** Default to explaining, answering questions, and suggesting. Let the user write the code.

## Project

Godot 4.7 (GL Compatibility) tower-defense game for GitHub Game Off 2026. Pure GDScript, no build/lint/test tooling. 640x360 viewport, `canvas_items` stretch, nearest-neighbor texture filtering (pixel art).

Run: open in the Godot editor and press F5. Main scene is `examples/lite_demo.tscn` (not `main.tscn`, which is empty).

## Architecture

Game logic is a reusable "TD core" in `assets/scripts/` (`class_name TD*`), driven by one data file; `examples/lite_demo.gd` is the playable level and the only code that draws sprites or handles input.

- `TDContent` loads `examples/data/content.json` (towers, enemies, waves, map, start gold/lives). New towers/enemies/waves are data-only edits. It is also the factory (`make_tower`, `make_map`) and has `validate()`.
- `TDWaveSpawner` is the hub node: `configure(content)` creates the `TDMap` and `TDEconomy`, then spawns `TDEnemy` nodes, owns placement/selling, and ticks towers via `advance(delta)`. Other objects talk through signals (`enemy_spawned`, `tower_placed`, `all_waves_cleared`, `economy.defeated`).
- `TDMap`: grid cells built from waypoints; converts cell<->pixel, exposes ground and air paths.
- `TDTower` / `TDEnemy`: stats come from level dicts in the JSON; enemies follow a path and take damage/slow; towers pick targets by a `Targeting` mode.
- `TDEconomy`: gold and lives, with signals.

Core nodes draw a gray debug shape by default; the demo sets `debug_draw = false` on spawned towers/enemies and draws its own sprites and HP bars.

## Assets

- `assets/sprites/*.png` are Kenney Tower Defense (CC0), referenced by name from JSON and loaded as `res://assets/sprites/<name>.png`. Record licences in `assets/ASSET_LICENSES.md`.
- `sprites/*.aseprite` and `dawnbringer-16.hex` are the author's own in-progress art (DawnBringer 16 palette), outside `assets/`.

## Conventions

Tabs for indentation (`.editorconfig`). Typed GDScript (typed vars, `Array[T]`, `-> void`) and `##` doc comments throughout.
