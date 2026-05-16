---
description: >
  Code Quest is a browser-based gamified experience for kids (ages 10-13) that
  teaches spec-driven development through pixel-art agent characters. A kid types
  a one-sentence idea, then watches four animated agents guide them through
  planning, designing, testing, and building — asking kid-friendly questions
  along the way. At the end, the kid receives a pre-made starter project folder
  with instructions on how to run it. The process simulates the codeplain
  forge-plain workflow without requiring a real API key.
---

***definitions***
- :App: is the Code Quest web application.
- :Kid: is the user of :App:. :Kid: is a child aged 10-13 who wants to build something with code.
- :Office: is the pixel-art game space where agent characters live and work. :Office: displays:
  - A tiled floor area with furniture and decorations
  - Animated agent characters that walk, sit, and interact
  - A visual representation of quest progress
- :Agent: is a pixel-art character in :Office: that guides :Kid: through one :Phase: of :Quest:. There are exactly four agents:
  - Spark — the Ideas agent. Creative personality. Handles Phase 1 (what to build).
  - Pixel — the Design agent. Technical personality. Handles Phase 2 (how to build it).
  - Scout — the Testing agent. Careful personality. Handles Phase 3 (how to verify it).
  - Bolt — the Build agent. Fast personality. Handles Phase 4 (assembling the project).
- :Quest: is the full journey from :Kid: typing an idea to receiving a finished :ProjectTemplate:. :Quest: progresses through four :Phase: stages in order.
- :Phase: is one of the four stages of a quest. Each :Phase: is owned by one agent. The phases are:
  - Phase 1 (Spark) — gather the idea and ask what to build
  - Phase 2 (Pixel) — decide design choices (language, style)
  - Phase 3 (Scout) — set up how to test and verify the project
  - Phase 4 (Bolt) — assemble the final output and deliver it
- :Question: is what an :Agent: asks :Kid: during a :Phase:. :Question: has:
  - Prompt text — the question in kid-friendly language
  - Answer options — clickable buttons for common answers (optional)
  - Free text input — a text field for creative answers (optional)
  - At least one of answer options or free text input must be present.
- :ProjectTemplate: is the pre-made starter project that :Kid: receives at the end of a quest. :ProjectTemplate: has:
  - A folder of source files ready to run
  - A kid-friendly README with instructions on how to use the project
  - A name matching what :Kid: described in Phase 1
- :ProgressBar: is a visual indicator in :Office: that shows which :Phase: of :Quest: the :Kid: is currently in. :ProgressBar: displays:
  - Four segments, one per :Phase:
  - The active segment is highlighted with the current :Agent: color/icon
  - Completed segments are filled, upcoming segments are dimmed
- :ChatBubble: is the speech-bubble UI element through which :Agent: communicates with :Kid:. :ChatBubble: displays:
  - The :Agent: name and avatar at the top
  - The :Question: prompt text in the body
  - Answer options as clickable buttons below the text
  - A text input field when free-text answers are accepted
- :AssetCatalog: describes the pixel-art assets used to render :Office: and :Agent: characters. The full catalog of available sprites, tiles, furniture, and character sheets is defined in [pixel-agents-public-assets/pixel-agents-public-assets.yaml](pixel-agents-public-assets/pixel-agents-public-assets.yaml). Assets are organized under the folder public/assets with subfolders for characters, floors, walls, and furniture. In a Vite project, the public/ folder is served at the root, so assets are referenced as /assets/ in code.

***functional specs***
- Implement the entry point for :App:. :App: is a single-page web application that serves an HTML page with a canvas-based :Office: view.

- Render :Office: floor and walls as a pixel-art tiled environment from :AssetCatalog:.
  - The office uses a fixed grid of 16x16 pixel tiles.
  - Floor tiles are drawn from the floors folder in :AssetCatalog:.
  - Walls are drawn from the walls folder in :AssetCatalog:.

- Render a single furniture sprite at a given tile position in :Office: using sprites from the furniture folder in :AssetCatalog:.

- For each entry in the loaded furniture layout, render the corresponding furniture item at its tile position in :Office:.

- Furniture positions are loaded from a layout data file at startup and used to place each item in :Office:.

- Load a single :Agent: character sprite sheet from :AssetCatalog: given a character index (char_0, char_1, char_2, or char_3 from the characters folder) and return the loaded image.

- At startup, load all four :Agent: sprites: Spark uses char_0, Pixel uses char_1, Scout uses char_2, Bolt uses char_3.

- Display a single :Agent: at a given pixel position in :Office: by drawing the idle frame from its loaded sprite sheet.

- At startup, place all four :Agent: characters at their assigned desk positions in :Office: in idle state.




- Show a centered text input with the prompt "What do you want to build?" and a "Go!" submit button over :Office:.

- When :Kid: clicks "Go!", hide the text input and start :Quest: with Spark as the active :Agent:.

- Show the active :Agent: name as a bold label below the :Office: canvas.

- Show the current :Question: text below the :Agent: name label.

- For each :Question:, render its answer options as HTML buttons below the question text. If the :Question: has a text input instead of buttons, render a single text input with a "Next" button.

- Spark asks: "Cool idea! What kind of project is this?" with buttons "A game", "A website", "A tool", "Something else".

- Spark asks: "What is the most important thing it should do?" with a text input field.

- Spark asks: "Who will use it?" with buttons "Just me", "My friends", "Everyone".

- After :Kid: answers all of Spark's questions, Pixel becomes the active :Agent:.

- Pixel asks: "What should it look like?" with buttons "Colorful and fun", "Simple and clean", "Dark and techy".

- Pixel asks: "Pick a language!" with buttons "Python", "JavaScript", "I don't know".

- After :Kid: answers all of Pixel's questions, Scout becomes the active :Agent:.

- Scout asks: "Should I add tests so you know it works?" with buttons "Yes, add tests!", "No thanks, just build it".

- After :Kid: answers Scout's question, Bolt becomes the active :Agent:.

- Bolt shows "Leave it to me! Building your project..." for 3 seconds, then shows "Done! Your project is ready!".

- After Bolt finishes, show a "Download my project!" button that downloads a .zip file containing :ProjectTemplate:.

- Select :ProjectTemplate: based on :Kid: project type answer and language answer. Default to HTML/CSS/JS if no match.

- Personalize the README in :ProjectTemplate: with :Kid: project name and idea before packaging the .zip.

- The .zip file name is derived from :Kid: idea text (lowercased, spaces replaced with dashes).

- After download, show a "Start a new quest!" button that resets :Quest: and shows the idea input again.

- If :Kid: submits an empty idea, block submission and show "Type something first!" below the input.

- While :App: assets are loading, show "Loading quest..." centered on screen.

- :Quest: state is not persisted. Refreshing the browser resets to the idea input screen.

- The idea text input has a maximum length of 100 characters.

- :App: canvas is 800x600 pixels with nearest-neighbor rendering for crisp pixels.

***implementation reqs***
- Use TypeScript as the programming language.
- Use HTML5 Canvas API for all rendering (office, agents, UI overlays). No game framework or rendering library.
- Use Vite as the build tool and development server.
- Use JSZip for client-side .zip file generation and download.
- All pixel-art assets are placed in the project's public/assets/ folder (copied from pixel-agents-public-assets/public/assets/) and referenced at runtime as /assets/ paths via image elements.
- Use nearest-neighbor (image-rendering: pixelated) CSS on the canvas for crisp pixel scaling.
- The project structure follows standard Vite TypeScript conventions: src/ for source, public/ for static assets.
- No server-side logic. The entire app runs in the browser.

***test reqs***
- Use Vitest as the test framework.
- Write unit tests for quest state management, template selection logic, and input validation.
- Write snapshot tests for canvas rendering output to catch visual regressions.
- Tests are run via a PowerShell script in test_scripts/.
