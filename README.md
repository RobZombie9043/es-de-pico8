## 🕹️ Native PICO-8 Setup for ES-DE on Android through Winlator

You can run native **PICO-8** on Android via **Winlator** and launch game carts or Splore directly from **ES-DE**.


https://github.com/user-attachments/assets/661bf45b-6a51-4bab-9d2b-11b1d6e30f6f


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

- Download [`pico8_launcher.sh`](https://github.com/RobZombie9043/es-de-pico8/blob/main/pico8_launcher.sh)
- If your drive letter you assigned for the pico8 folder earlier was something other than F: then open the script in a text editor.

Update the following line with your **Winlator drive letter** from earlier:

```bash
WIN_ROM_FILE="F:\\\\$ROM_FILE"
```

> 💡 For example, if your drive letter is `G:`, it should look like:.

```bash
WIN_ROM_FILE="G:\\\\$ROM_FILE"
```


- Save the file and copy it to:

```bash
~ES-DE/scripts/game-start/pico8_launcher.sh
```

---

### 🗂️ Custom system setup in ES-DE

#### 8. Edit your custom `es_systems.xml` file and add the following block to add winlator to the pico8 system:

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
 - SD card would be something like:
```bash
/storage/XXXX-XXXX/ROMs/pico8/pico8.desktop
```
where xxxx-xxxx is the unique sd card identifier   

 - Internal storage would be something like:   
```bash
/storage/emulated/0/ROMs/pico8/pico8.desktop
```

An example custom system file can be found here [es_systems.xml](https://github.com/RobZombie9043/es-de-pico8/blob/main/es_systems.xml)

- Save the file to:
```bash
~ES-DE/custom_systems/es_systems.xml
```

> 💡 After making changes to the es_systems.xml make sure to fully exit out of ES-DE and restart it for the custom systems to be loaded.

---

### 🎮 Final Steps

1. Place `.p8` or `.png` or `.p8.png` carts into your `ROMs/pico8` folder.
2. [Optional] To be able to launch Splore, create a blank file named Splore.p8.png and place this into your `ROMs/pico8` folder. This can be downloaded here - [Splore.p8.png](https://github.com/RobZombie9043/es-de-pico8/blob/main/Splore.p8.png)
3. In ES-DE, set the **alternative emulator** for the `pico8` system:
   - Choose `Winlator (PRoot)` or `Winlator (Glibc)` depending on your installed fork.
4. **Rescan ROMs** in ES-DE.
5. **Launch your PICO-8 carts** from the `PICO-8` system tab!
---

## 🔍 How This Works

- **Winlator** uses `.desktop` files to pass launch parameters to it to launch Windows applications.
- **PICO-8** reads the `execArgs` value in the `.desktop` file to determine which game cart to load or whether to launch **Splore**.
- The `pico8_launcher.sh` script is executed by ES-DE before launching a game.
   - It modifies the `.desktop` file to update the `execArgs` field with the path to the selected PICO-8 cart.
   - When Winlator is launched, it passes this updated `.desktop` file to PICO-8, which then loads the correct game.

This creates seamless integration between **ES-DE**, **Winlator**, and **native PICO-8**, allowing you to browse and launch carts just like any other system.

---
