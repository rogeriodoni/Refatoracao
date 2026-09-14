# VFP9 Control Properties Reference

Reference of valid properties, methods, and events per VFP9 control type.
Source: HackFox (hackfox.github.io/section4/) + project experience.

**Use this to prevent "Property XXX is not found" errors.**

---

## Grid

### Valid Properties
| Property | Type | Default | Notes |
|----------|------|---------|-------|
| ColumnCount | Numeric | -1 | -1=auto. Set BEFORE accessing Column1/Column2 |
| RecordSource | Character | "" | Alias/cursor name. **Setting resets ALL column customizations** |
| RecordSourceType | Numeric | 0 | 0=Table, 1=Alias, 2=Prompt, 3=QPR, 4=SQL |
| ActiveColumn | Numeric | | Uses ColumnOrder, not creation order |
| ActiveRow | Numeric | | Absolute row number |
| DeleteMark | Logical | .T. | Show delete mark column |
| RecordMark | Logical | .T. | Show record pointer column |
| ReadOnly | Logical | .F. | Grid inteiro somente leitura |
| RowHeight | Numeric | | Pixels |
| HeaderHeight | Numeric | | Pixels |
| ScrollBars | Numeric | 3 | 0=None, 1=Horizontal, 2=Vertical, 3=Both |
| GridLines | Numeric | 3 | 0=None, 1=Horizontal, 2=Vertical, 3=Both |
| GridLineColor | Numeric | | RGB value |
| GridLineWidth | Numeric | | Pixels |
| Highlight | Logical | | Highlight cell on tab entry |
| HighlightRow | Logical | | Highlight entire current row |
| LeftColumn | Numeric | | Leftmost visible column (uses ColumnOrder) |
| LinkMaster | Character | | Parent table alias |
| ChildOrder | Character | | Index tag for relations |
| Partition | Numeric | 0 | Split divider; 0=no split |
| AllowAddNew | Logical | .F. | Allow adding via down-arrow past last row |
| AllowHeaderSizing | Logical | .T. | Allow resizing columns |
| FontName | Character | | Grid-level font (Column NAO tem FontName!) |
| FontSize | Numeric | | Grid-level font size |

### Properties that DO NOT EXIST
- `AllowDelete` - NAO EXISTE
- `AllowEdit` - NAO EXISTE
- `AllowUpdate` - NAO EXISTE

### Events
| Event | Parameters | Notes |
|-------|-----------|-------|
| AfterRowColChange | nColIndex | Fires AFTER focus moves. Handler DEVE declarar par_nColIndex |
| BeforeRowColChange | nColIndex | Fires BEFORE. Can cancel |
| Scrolled | nDirection | On scrollbar use |
| Click | (none) | Only fires on empty rows/marks, NOT on columns |
| KeyPress | nKeyCode, nShiftAltCtrl | Handler DEVE declarar ambos parametros |

### Methods
| Method | Purpose |
|--------|---------|
| ActivateCell | Set focus to specific cell |
| AddColumn | Add column to grid |
| RemoveColumn | Remove column from grid |
| DoScroll | Scroll programmatically |
| SetAll | Set property on all contained objects |

### GOTCHAS
- **Setting RecordSource RESETS all column customizations** - reconfigure Width, ControlSource, Headers AFTER
- **Column NAO tem FontName/FontSize** - usar Grid.FontName diretamente
- **SetAll("FontName", ..., "Column") FALHA** - Column nao tem FontName
- **Grid Click event** fires only for empty rows/marks, not columns
- **AllowAddNew EXISTE** mas AllowDelete/AllowEdit/AllowUpdate NAO existem

---

## Column (Grid.ColumnN)

### Valid Properties
| Property | Type | Notes |
|----------|------|-------|
| Bound | Logical | Bind to ControlSource |
| ColumnOrder | Numeric | Visual display position (EVITAR - causa desalinhamento) |
| ControlCount | Numeric | Number of controls in column |
| CurrentControl | Character | Active control name |
| ControlSource | Character | "cursor.campo" - cursor DEVE existir ANTES |
| Movable | Logical | User can drag column |
| Resizable | Logical | User can resize |
| SelectOnEntry | Logical | Select content on tab |
| Sparse | Logical | .T.=show control only on focus |
| Width | Numeric | Column width in pixels |
| Alignment | Numeric | 0=Left, 1=Right, 2=Center, 3=Auto |
| DynamicBackColor | Character | Expression evaluated per cell |
| DynamicForeColor | Character | Expression evaluated per cell |
| DynamicAlignment | Character | Expression per cell |
| DynamicCurrentControl | Character | Expression per cell |
| DynamicFontBold | Character | Expression per cell |
| DynamicFontItalic | Character | Expression per cell |
| DynamicFontName | Character | Expression per cell |
| DynamicFontSize | Character | Expression per cell |
| DynamicInputMask | Character | Expression per cell |

### Properties that DO NOT EXIST on Column
- `FontName` - usar DynamicFontName ou Grid.FontName
- `FontSize` - usar DynamicFontSize ou Grid.FontSize
- `FontBold` - usar DynamicFontBold

### GOTCHAS
- `.Name = "X"` renames Column, breaking `.Column1` references - NUNCA usar .Name
- ControlSource requer cursor existente ANTES de definir
- Usar `.Buttons(1)` syntax para acessar controles dentro

---

## Header (Grid.ColumnN.Header1)

### Valid Properties
| Property | Notes |
|----------|-------|
| Caption | Header text |
| Alignment | 0=Left, 1=Right, 2=Center |
| FontName | Font name |
| FontSize | Font size |
| FontBold | Bold text |
| BackColor | Background color |
| ForeColor | Text color |
| WordWrap | Allow text wrap (VFP 7+) |

---

## PageFrame

### Valid Properties
| Property | Type | Notes |
|----------|------|-------|
| ActivePage | Numeric | Which page is on top (uses PageOrder) |
| PageCount | Numeric | **MUST set BEFORE accessing .Page1/.Page2** |
| Tabs | Logical | .T.=show tabs, .F.=hide tabs |
| TabStyle | Numeric | Tab appearance |
| Top | Numeric | Position |
| Left | Numeric | Position |
| Width | Numeric | Size |
| Height | Numeric | Size |

### Properties that DO NOT EXIST
- `BackColor` - usar Page1.BackColor, Page2.BackColor
- `ForeColor` - usar nas Pages
- `ErasePage` - NAO existe em VFP9
- `FontName` - NAO existe em PageFrame. Definir nas Pages ou nos controles internos
- `FontSize` - NAO existe em PageFrame. Definir nas Pages ou nos controles internos

### GOTCHAS
- **PageCount ANTES de .Page1** - "Unknown member PAGE1" se acessar antes
- **Pages NAO tem .Visible** - usar PageFrame.Visible
- **ActivePage Assign bug** - NAO dispara quando usuario clica na aba (apenas keyboard/code)
- **`.Name` em Pages** rename e quebra .PageN references - NUNCA usar

---

## Page (PageFrame.PageN)

### Valid Properties
| Property | Notes |
|----------|-------|
| BackColor | Background color |
| ForeColor | Text color |
| Caption | Tab caption text |
| Picture | Background image |
| PageOrder | Display order |
| ControlCount | Number of controls |
| Controls | Collection of controls |

### Properties that DO NOT EXIST
- `Visible` - Pages NAO tem Visible

---

## Form

### Valid Properties
| Property | Type | Values/Notes |
|----------|------|-------------|
| Width | Numeric | Size in pixels |
| Height | Numeric | Size in pixels |
| Top | Numeric | Position |
| Left | Numeric | Position |
| Caption | Character | Title bar text |
| BackColor | Numeric | RGB background |
| ForeColor | Numeric | RGB text color |
| FontName | Character | Font name |
| FontSize | Numeric | Font size |
| BorderStyle | Numeric | 0=None, 1=Fixed Single, 2=Fixed Dialog, 3=Sizable |
| ControlBox | Logical | System menu. .F. disables Min/Max/Close too |
| TitleBar | Numeric | **0=No title bar, 1=Title bar. OVERRIDES ControlBox** |
| MaxButton | Logical | Maximize button |
| MinButton | Logical | Minimize button |
| Closable | Logical | Close button |
| Movable | Logical | User can move |
| Themes | Logical | Windows themes (.F. for classic look) |
| ClipControls | Logical | Repaint optimization |
| ShowWindow | Numeric | 0=In screen, 1=Top-level, 2=Top-level modal |
| WindowType | Numeric | 0=Modeless, 1=Modal |
| AutoCenter | Logical | Center on show |
| Desktop | Logical | MDI vs standalone |
| AlwaysOnTop | Logical | Stay on top |
| KeyPreview | Logical | Form catches keys first |
| LockScreen | Logical | Defer visual updates |
| DataSession | Numeric | 1=Default, 2=Private |
| Picture | Character | Tiled wallpaper |
| Icon | Character | Title bar icon file |
| ScrollBars | Numeric | 0=None, 1=H, 2=V, 3=Both |
| ShowInTaskBar | Logical | Top-level forms only |
| ShowTips | Logical | Tooltip display |
| hWnd | Numeric | Windows handle (read-only) |
| ReleaseType | Numeric | How released (read-only) |
| BufferMode | Numeric | Cursor buffering |

### Form Event Order (creation)
1. DataEnvironment.BeforeOpenTables
2. DataEnvironment.OpenTables
3. Load
4. DataEnvironment.Init
5. Control Inits (inside-out)
6. Form Init
7. Activate / GotFocus

### Form Event Order (destruction)
1. Form Destroy
2. Control Destroys
3. Unload
4. DataEnvironment.Destroy/CloseTables

### Key Methods
| Method | Notes |
|--------|-------|
| Release | Destroy form. **Only Form has Release - Custom/BO NAO tem** |
| Show | Show and activate. Show(1) for modal (mas usar WindowType=1) |
| Hide | Hide form (object remains accessible) |

### GOTCHAS
- **TitleBar=0 overrides everything** - no control menu, no buttons
- **ShowWindow=1, WindowType=1** for modals (NAO usar ShowWindow=2)
- **Release() apenas em Form** - Custom/BO usar = .NULL.

---

## Container

### Valid Properties
| Property | Type | Notes |
|----------|------|-------|
| BackColor | Numeric | Background (only when BackStyle=1) |
| BackStyle | Numeric | 0=Transparent, 1=Opaque |
| BorderWidth | Numeric | Border thickness |
| BorderColor | Numeric | Border color |
| ControlCount | Numeric | Number of controls |
| Controls | Collection | All controls |

### Methods
- AddObject(cName, cClass) - **Visible=.F. by default!**
- RemoveObject(cName)

---

## CommandButton

### Valid Properties
| Property | Type | Notes |
|----------|------|-------|
| Caption | Character | Button text |
| Width/Height | Numeric | Size |
| Top/Left | Numeric | Position |
| Picture | Character | Image (enabled state) |
| DownPicture | Character | Image when pressed |
| DisabledPicture | Character | Image when disabled |
| PicturePosition | Numeric | 0-13 (13=icon above text) |
| FontName | Character | Font |
| FontSize | Numeric | Font size |
| BackColor | Numeric | Background (requires Themes=.F.) |
| ForeColor | Numeric | Text color |
| Themes | Logical | .F. for classic look |
| SpecialEffect | Numeric | 0=3D, 1=Plain, 2=Hot tracking |
| Default | Logical | Activate on Enter |
| Cancel | Logical | Activate on Esc |
| AutoSize | Logical | Resize to fit caption |
| Enabled | Logical | Enabled state |
| Visible | Logical | Visible state |

---

## CommandGroup

### Valid Properties
| Property | Type | Notes |
|----------|------|-------|
| ButtonCount | Numeric | **MUST set BEFORE accessing Buttons(n)** |
| Buttons | Collection | Access via Buttons(nIndex), NOT Button1 |
| BackStyle | Numeric | 0=Transparent |
| Value | Numeric/Char | Last selected button |

### GOTCHAS
- **ButtonCount ANTES de Buttons(1)** - "BUTTONS is not an object" sem ButtonCount
- **Usar Buttons(1), NAO Button1** - "Unknown member BUTTON1" com AddObject
- Setting group Enabled does NOT visually dim contained buttons

---

## OptionGroup

### Valid Properties
| Property | Type | Notes |
|----------|------|-------|
| ButtonCount | Numeric | **MUST set BEFORE accessing Buttons(n)** |
| Buttons | Collection | Access via Buttons(nIndex) |
| Value | Numeric | Selected option number |

### Properties that DO NOT EXIST
- `FontName` - definir nas Buttons(N).FontName individuais
- `FontSize` - definir nas Buttons(N).FontSize individuais

### GOTCHAS
- Usar `.Buttons(1)` syntax, NAO `.Button1`
- Cada Button precisa de .Left, .Top, .AutoSize, .ForeColor, .Themes
- Sem Left/Top definido, buttons ficam sobrepostos

---

## TextBox

### Valid Properties
| Property | Type | Notes |
|----------|------|-------|
| Value | Variant | **Default = .F. (logical!)** - inicializar como "" para string |
| InputMask | Character | Input format mask |
| Format | Character | Display format |
| ControlSource | Character | Data binding |
| PasswordChar | Character | Mask character |
| MaxLength | Numeric | Max characters |
| SelectOnEntry | Logical | Select on focus |
| HideSelection | Logical | Hide selection on lost focus |
| Alignment | Numeric | 0=Left, 1=Right, 2=Center, 3=Auto |
| ReadOnly | Logical | Read-only state |

### GOTCHAS
- **Default Value = .F.** - SEMPRE inicializar: .Value = "" (string), .Value = 0 (numerico), .Value = {} (data)
- TextBox.ControlSource dentro de Grid Column: usar Column.ControlSource, NAO TextBox.ControlSource

---

## CheckBox

### Valid Properties
| Property | Type | Notes |
|----------|------|-------|
| Value | Variant | .T./.F. (logical) OU 0/1 (numeric) - ser CONSISTENTE |
| Caption | Character | Label text |
| AutoSize | Logical | Auto resize |

### GOTCHAS
- **Tipo do Value deve ser consistente** - se iniciar com .F., usar .T./.F. em TODOS os acessos
- Converter de banco: `(NVL(campo,0) = 1)` retorna logico

---

## Init / Destroy Events (ALL objects)

### Init
- Fires on object creation (constructor)
- Accepts parameters from CREATEOBJECT/AddObject
- **Can return .F.** - creates reference but sets to .NULL.
- Control Inits fire BEFORE form Init (inside-out)
- Save parameter values to properties - released after Init ends

### Destroy
- Fires on object release (destructor)
- Container Destroy fires FIRST, then contained objects (outside-in)
- No return value

---

## AddObject (ALL containers)

```foxpro
oObject.AddObject(cName, cClass [, cOLEClass] [, uParamList])
```

- **Objects added at runtime ALWAYS have Visible=.F.** - must set .Visible = .T.
- Requires prior SET CLASSLIB/PROCEDURE for custom classes
- Use LockScreen to prevent flicker during bulk manipulation
