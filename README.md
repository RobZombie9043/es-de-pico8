## 🕹️ Native PICO-8 Setup for ES-DE on Android

You can run native **PICO-8** on Android via **Winlator** and launch games directly from **ES-DE** using `.desktop` files.

---

### ✅ Requirements

- A **Winlator fork** that supports frontend launching (e.g. `cmod proot`, `glibc`, or `bionic` forks)
- A **copy of PICO-8 for Windows**
- ES-DE installed and configured

---

### 🧩 Setup Instructions

#### 1. **Install Winlator**

Download and install a Winlator fork that supports launching `.desktop` files via frontend (like `Cmod Proot` or `Cmod Glibc` versions or one of the `Bionic forks` ).

#### 2. **Create a Container in Winlator**

- Open Winlator, tap **Create Container**.
- Under the **DRIVES** section, tap **Add**.
- Use the folder button to select your `ROMs/pico8` folder.
- **Remember the assigned drive letter** (e.g., `F:`).

#### 3. **Install PICO-8**

- Launch the container.
- Use the **Windows installer** to install PICO-8.
- After installation, **create a shortcut** to `pico8.exe`.

#### 4. **Export the Shortcut**

- In Winlator, select the PICO-8 shortcut.
- Tap **Export for Frontend**.
- This creates a `.desktop` file (e.g., `pico8.desktop`).

#### 5. **Move the Shortcut File**

- Copy `pico8.desktop` to your `ROMs/pico8` folder.

---

### 🛠️ Script Setup for ES-DE

#### 6. **Enable Custom Scripts in ES-DE**

- Go to **ES-DE Settings → Other Settings**.
- Enable: **"Enable custom event scripts"**

#### 7. **Download and Configure Launcher Script**

- [Download `pico8_launcher.sh`](#) ← *(Replace with actual link)*
- Open the script in a text editor.

Update the following line with your **Winlator drive letter** from earlier:

```bash
WIN_ROM_FILE="F:\\\\$ROM_FILE"
```

> 💡 For example, if your drive letter is `F:`, it should look exactly like above.

- Save the file and copy it to:

```bash
~ES-DE/scripts/game-start/pico8_launcher.sh
```

---

### 🗂️ Add PICO-8 to `es_systems.xml`

Edit your `es_systems.xml` file and add the following block:

```xml
<system>
    <name>pico8</name>
    <fullname>PICO-8 Fantasy Console</fullname>
    <path>%ROMPATH%/pico8</path>
    <extension>.desktop .p8 .P8 .png .PNG</extension>
    <command label="Winlator Cmod Glibc (Standalone)">
        %EMULATOR_WINLATOR-GLIBC% %ACTIVITY_CLEAR_TASK% %ACTIVITY_CLEAR_TOP% %EXTRA_shortcut_path%=/storage/XXXX-XXXX/ROMs/pico8/pico8.desktop
    </command>
    <command label="Winlator Cmod PRoot (Standalone)">
        %EMULATOR_WINLATOR-PROOT% %ACTIVITY_CLEAR_TASK% %ACTIVITY_CLEAR_TOP% %EXTRA_shortcut_path%=/storage/XXXX-XXXX/ROMs/pico8/pico8.desktop
    </command>
    <command label="Fake-08">
        %EMULATOR_RETROARCH% %EXTRA_CONFIGFILE%=/storage/emulated/0/Android/data/%ANDROIDPACKAGE%/files/retroarch.cfg %EXTRA_LIBRETRO%=/data/data/%ANDROIDPACKAGE%/cores/fake08_libretro_android.so %EXTRA_ROM%=%ROM%
    </command>
    <command label="Retro8">
        %EMULATOR_RETROARCH% %EXTRA_CONFIGFILE%=/storage/emulated/0/Android/data/%ANDROIDPACKAGE%/files/retroarch.cfg %EXTRA_LIBRETRO%=/data/data/%ANDROIDPACKAGE%/cores/retro8_libretro_android.so %EXTRA_ROM%=%ROM%
    </command>
    <command label="Infinity (Standalone)">
        %EMULATOR_INFINITY% %ACTION%=android.intent.action.VIEW %DATA%=%ROMPROVIDER%
    </command>
    <platform>pico8</platform>
    <theme>pico8</theme>
</system>
```

> 🔧 Be sure to replace `/storage/XXXX-XXXX/ROMs/pico8/pico8.desktop` with your actual storage device ID and path where the `.desktop` file is located.   
SD card would be something like `/storage/XXXX-XXXX/ROMs/pico8/pico8.desktop` where xxxx-xxxx is the unique sd card identifier   
Internal storage would be something like: `/storage/emulated/0/ROMs/pico8/pico8.desktop`   

---

### 🎮 Final Steps

1. Place `.p8` or `.png` carts into your `ROMs/pico8` folder.
2. In ES-DE, set the **alternative emulator** for the `pico8` system:
   - Choose `Winlator (PRoot)` or `Winlator (Glibc)` depending on your installed fork.
3. **Rescan ROMs** in ES-DE.
4. **Launch your PICO-8 carts** from the `PICO-8` system tab!

---
