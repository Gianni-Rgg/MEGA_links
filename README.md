# 🪄 MEGA_links

A fast, stupidly simple PowerShell prank project.  
Download → run a `.bat` → chaos (or not).

No installers.  
No dependencies.  
No patience required.  
No regrets (maybe).

---

## 🚀 What is MEGA_links?

**MEGA_links** is a tiny PowerShell prank system driven entirely by **batch files**.

You don’t need to understand PowerShell.  
You don’t need admin rights.  
You don’t need a plan.

👉 Just download the project and **double‑click a `.bat` file**.

Execution takes **seconds**.  
Psychological damage may last longer.

---

## 🖥️ What does it prank exactly? (important, really)

**MEGA_links only pranks the shortcuts (links) on the Desktop.**  
Nothing else. No files are touched. No data is harmed.

- All `.lnk` shortcuts on the Desktop are temporarily replaced
- After the prank, **everything is restored exactly as it was**
- Same shortcut names
- Same targets
- Same locations

It’s basically *harmless chaos with a rollback button*.

---

## ⚙️ How it works (simple version)

- The **`.bat` files** are the entry point  
- Each `.bat` launches `MEGA_links.ps1` with a specific **mode**
- The PowerShell script does the dirty work:
  - displays an image
  - blocks (or politely doesn’t block) the user
  - cleans everything after itself
  - installs persistence (only if you really asked for it)

No services.  
No registry madness.  
Just vibes.

---

## 🎭 Available modes

### 😈 without_empathy
- Opens a **PNG image in fullscreen with a sound**
- Makes escaping slightly annoying (fullscreen, Alt+Tab blocked)
- Forces the user to *emotionally accept the situation*
- Once the window is closed (by killing the process or whatever):
  - everything is **cleaned**
  - nothing remains
  - no evidence, no witnesses

> Short. Brutal. Memorable.

---

### 🤝 with_empathy
- Opens the PNG image
- Nothing else
- No blocking
- No persistence
- No stress

> The “I’m not a monster” mode.

---

### 🤪 wtf_is_wrong_with_you
- Installs the script in **persistent mode**
- Creates a **hidden scheduled task to launch the without_empathy mode at least once a week**
- The prank can come back later  
  *(randomly, because why not)*

> Special mode for people with questionable life choices.

---

## ▶️ Usage

1. Download the repository  
2. Extract it  
3. Double click **one `.bat` file**  
4. Delete the folder to remain discreet
5. Walk away like nothing happened  

That’s it.  
Seriously.

---

## 🔊 Sound effects (yes, on purpose)

Some modes include **audio playback** because silence is suspicious:

- **without_empathy**
  - Plays a sound
  - Displays the fullscreen image
  - Emotional damage: enabled

- **wtf_is_wrong_with_you**
  - Also plays a sound
  - Possibly later, randomly
  - Psychological warfare mode

- **with_empathy**
  - No audio
  - You’re still a good person (probably)

The sound is intentional.  
The timing is not your friend’s.

---

## 🧹 Cleanup & stealth mode

After the prank finishes:

- The generated **`.bat` file deletes itself**
- Temporary files (image, audio, archives) are removed
- No visible leftovers
- No obvious traces for the average user

Clean prank. Dirty looks.

---

## 🛟 save_him_from_hell (the panic button)

Yes. There *is* a way out.

The **`save_him_from_hell`** mode:

- Fully **uninstalls the prank**
- Restores **all Desktop shortcuts**
- Removes persistence (scheduled task if installed)
- Cleans backups and temporary data

The script lives here:
```
C:\Users\%USERNAME%\Data\
```


Run it if:
- you feel bad
- your friend stopped laughing
- HR is asking questions
- you chose violence but now seek forgiveness

---

## 🧠 FAQ

**Q: Is this malware?**  
A: No. It’s worse. It’s intentional.

**Q: Can I remove it?**  
A: Yes. Just open cmd and run:
``` cmd
cd "C:\Users\%USERNAME%\Data\"
.\save_him_from_hell.bat
```
**Q: Will my friend forgive me?**  
A: That depends on the mode you chose.

---

## ⚠️ Disclaimer (yes, read this)

This project is made for **educational and prank purposes only**.

- Don’t use it on machines you don’t own  
- Don’t use it in professional environments  
- Don’t use it on your boss  
- Don’t use it on yourself (seriously)

I am not responsible for:
- broken friendships
- trust issues
- people staring at their screen in silence

This is a **Desktop shortcut prank**
- Not malware
- Not destructive
- Not permanent
- Not subtle (emotionally)

Technically clean.  
Psychologically questionable.

You are responsible for your life choices.

---

## ⭐ Final words

Use **with_empathy** if you’re nice.  
Use **without_empathy** if you’re honest.  
Use **wtf_is_wrong_with_you** if you’ve already accepted who you are.

Enjoy.
