#!/usr/bin/env python3
"""
Generate *_best_view.dart files for all modules in AIR App
with creative, varied UI/UX design patterns.
"""

import os
import re
from pathlib import Path

# Base directory
BASE_DIR = Path(__file__).parent
MODULES_DIR = BASE_DIR / "lib" / "modules"

# Design themes - cycle through for variety
DESIGN_THEMES = [
    {
        "name": "Glasomorphism",
        "palette": "Frost",
        "colors": {
            "bg": "0xfff5f5f5",
            "bg_accent": "0xffe0e0e0",
            "primary": "0xff4a90e2",
            "accent": "0xffff6b6b",
            "text": "0xff2c3e50",
            "glass": "rgba(255, 255, 255, 0.5)",
        },
        "style": "glasomorphic_gradient_blur",
    },
    {
        "name": "Neumorphic",
        "palette": "Soft",
        "colors": {
            "bg": "0xffe0e5ec",
            "light": "0xffffffff",
            "dark": "0xffa3b1c6",
            "primary": "0xff667eea",
            "accent": "0xfff093fb",
            "text": "0xff2c3e50",
        },
        "style": "neumorphic_shadows",
    },
    {
        "name": "Gradient Material",
        "palette": "Vibrant",
        "colors": {
            "bg": "0xff1a1a2e",
            "bg2": "0xff16213e",
            "primary": "0xffe94560",
            "accent": "0xfff39c12",
            "light": "0xffeee5e5",
            "text": "0xffffffff",
        },
        "style": "gradient_material_design",
    },
    {
        "name": "Dark Neon",
        "palette": "Cyber",
        "colors": {
            "bg": "0xff0f0f1e",
            "bg2": "0xff1a1a2e",
            "neon_cyan": "0xff00f0ff",
            "neon_pink": "0xffff006e",
            "neon_purple": "0xffb537f2",
            "text": "0xfff0f0f0",
        },
        "style": "dark_neon_accent",
    },
    {
        "name": "Minimalist",
        "palette": "Clean",
        "colors": {
            "bg": "0xfffafafa",
            "bg_alt": "0xfff5f5f5",
            "primary": "0xff2c3e50",
            "accent": "0xffe74c3c",
            "border": "0xffdedede",
            "text": "0xff34495e",
        },
        "style": "minimalist_typography",
    },
    {
        "name": "Card Cascade",
        "palette": "Modern",
        "colors": {
            "bg": "0xfff8f9fa",
            "card": "0xffffffff",
            "primary": "0xff3498db",
            "success": "0xff2ecc71",
            "warning": "0xfff39c12",
            "error": "0xffe74c3c",
        },
        "style": "card_cascade_layout",
    },
    {
        "name": "Animated Hero",
        "palette": "Dynamic",
        "colors": {
            "bg": "0xffecf0f1",
            "primary": "0xff9b59b6",
            "secondary": "0xff3498db",
            "accent": "0xffe67e22",
            "light": "0xffbdc3c7",
            "text": "0xff2c3e50",
        },
        "style": "animated_hero_sections",
    },
    {
        "name": "Tab Navigation",
        "palette": "Organized",
        "colors": {
            "bg": "0xffffffff",
            "tab_bg": "0xfff0f0f0",
            "tab_active": "0xff2980b9",
            "content_bg": "0xffecf0f1",
            "accent": "0xff16a085",
            "text": "0xff2c3e50",
        },
        "style": "tab_navigation_centered",
    },
    {
        "name": "Expansion Tiles",
        "palette": "Hierarchical",
        "colors": {
            "bg": "0xfffff9e6",
            "tile_bg": "0xfff5f1e8",
            "primary": "0xff8b4513",
            "accent": "0xffd4af37",
            "light": "0xffefe4b0",
            "text": "0xff3e2723",
        },
        "style": "expansion_tree_view",
    },
    {
        "name": "Modal Focus",
        "palette": "Overlay",
        "colors": {
            "bg": "0xff121212",
            "modal": "0xff1e1e1e",
            "modal_light": "0xff2d2d2d",
            "primary": "0xff4fc3f7",
            "accent": "0xffff5722",
            "text": "0xffffffff",
        },
        "style": "modal_dialog_focused",
    },
]

def get_module_name_from_path(module_path):
    """Convert path to class name."""
    name = Path(module_path).name
    words = name.split("_")
    return "".join(w.capitalize() for w in words)

def get_enhanced_view_class_name(module_name):
    """Get the enhanced view class name."""
    return f"{get_module_name_from_path(module_name)}EnhancedView"

def get_best_view_class_name(module_name):
    """Get the best view class name."""
    return f"{get_module_name_from_path(module_name)}BestView"

def snake_to_pascal(snake_str):
    """Convert snake_case to PascalCase."""
    return "".join(w.capitalize() for w in snake_str.split("_"))

def create_best_view_file(module_path, module_name, design_theme_idx):
    """Create a *_best_view.dart file for a module."""
    
    theme = DESIGN_THEMES[design_theme_idx % len(DESIGN_THEMES)]
    
    module_short_name = Path(module_path).name
    class_name = snake_to_pascal(module_short_name)
    best_view_class = f"{class_name}BestView"
    enhanced_view_class = f"{class_name}EnhancedView"
    
    title = " ".join(w.capitalize() for w in module_short_name.split("_"))
    
    # Generate content based on design theme
    if theme["style"] == "glasomorphic_gradient_blur":
        view_content = f'''import 'package:flutter/material.dart';
import '{module_short_name}_enhanced_view.dart';

/// {class_name} Best View - Premium Creative Design
/// Theme: {theme["name"]} | Palette: {theme["palette"]}
/// Showcase: Glasomorphic design with frosted glass effect and modern blur backdrop
class {best_view_class} extends StatelessWidget {{
  const {best_view_class}({{super.key}});

  static const Color _bg = Color({theme["colors"]["bg"]});
  static const Color _primary = Color({theme["colors"]["primary"]});
  static const Color _accent = Color({theme["colors"]["accent"]});
  static const Color _text = Color({theme["colors"]["text"]});

  @override
  Widget build(BuildContext context) {{
    return Scaffold(
      backgroundColor: _bg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 280,
            backgroundColor: Colors.transparent,
            foregroundColor: _text,
            title: const Text(
              '{title}',
              style: TextStyle(
                letterSpacing: 1.5,
                fontWeight: FontWeight.w900,
                fontSize: 24,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [_primary.withValues(alpha:0.7), _accent.withValues(alpha:0.5)],
                      ),
                    ),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(color: Colors.transparent),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _BuildCard(
                    title: 'Premium Experience',
                    description: 'This is the enhanced best view with creative design.',
                    icon: Icons.star,
                  ),
                  const SizedBox(height: 16),
                  _BuildCard(
                    title: 'Rich Content',
                    description: 'Showcasing modern UI/UX design patterns.',
                    icon: Icons.palette,
                  ),
                  const SizedBox(height: 24),
                  const Divider(height: 32),
                  const Text(
                    'Original Content',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
          // Original view below
          SliverToBoxAdapter(
            child: SizedBox(
              child: SingleChildScrollView(
                child: const {enhanced_view_class}(),
              ),
            ),
          ),
        ],
      ),
    );
  }}
}}

class _BuildCard extends StatelessWidget {{
  final String title;
  final String description;
  final IconData icon;

  const _BuildCard({{
    required this.title,
    required this.description,
    required this.icon,
  }});

  @override
  Widget build(BuildContext context) {{
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha:0.8),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.1),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color({theme["colors"]["primary"]}),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }}
}}
'''
    
    elif theme["style"] == "neumorphic_shadows":
        view_content = f'''import 'package:flutter/material.dart';
import '{module_short_name}_enhanced_view.dart';

/// {class_name} Best View - Neumorphic Design
/// Theme: {theme["name"]} | Palette: {theme["palette"]}
/// Showcase: Soft UI with subtle shadows and depth perception
class {best_view_class} extends StatelessWidget {{
  const {best_view_class}({{super.key}});

  static const Color _bg = Color({theme["colors"]["bg"]});
  static const Color _light = Color({theme["colors"]["light"]});
  static const Color _dark = Color({theme["colors"]["dark"]});
  static const Color _primary = Color({theme["colors"]["primary"]});

  @override
  Widget build(BuildContext context) {{
    return Scaffold(
      backgroundColor: _bg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 260,
            backgroundColor: _bg,
            title: const Text(
              '{title}',
              style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Center(
                child: _NeumorphicContainer(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _NeumorphicButton(
                          icon: Icons.diamond,
                          label: 'Premium',
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '{title}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _NeumorphicContainer(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Best Features',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Neumorphic design showcase with creative UI patterns.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              child: SingleChildScrollView(
                child: const {enhanced_view_class}(),
              ),
            ),
          ),
        ],
      ),
    );
  }}
}}

class _NeumorphicContainer extends StatelessWidget {{
  final Widget child;

  const _NeumorphicContainer({{required this.child}});

  @override
  Widget build(BuildContext context) {{
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffe0e5ec),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha:0.8),
            offset: const Offset(-4, -4),
            blurRadius: 12,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha:0.1),
            offset: const Offset(4, 4),
            blurRadius: 12,
          ),
        ],
      ),
      child: child,
    );
  }}
}}

class _NeumorphicButton extends StatelessWidget {{
  final IconData icon;
  final String label;

  const _NeumorphicButton({{required this.icon, required this.label}});

  @override
  Widget build(BuildContext context) {{
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
        color: const Color(0xff667eea),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.2),
            offset: const Offset(4, 4),
            blurRadius: 12,
          ),
        ],
      ),
      child: Icon(icon, color: Colors.white, size: 28),
    );
  }}
}}
'''
    
    elif theme["style"] == "gradient_material_design":
        view_content = f'''import 'package:flutter/material.dart';
import '{module_short_name}_enhanced_view.dart';

/// {class_name} Best View - Gradient Material Design
/// Theme: {theme["name"]} | Palette: {theme["palette"]}
/// Showcase: Vibrant gradients with modern Material Design 3
class {best_view_class} extends StatelessWidget {{
  const {best_view_class}({{super.key}});

  static const Color _bg = Color({theme["colors"]["bg"]});
  static const Color _bg2 = Color({theme["colors"]["bg2"]});
  static const Color _primary = Color({theme["colors"]["primary"]});
  static const Color _accent = Color({theme["colors"]["accent"]});

  @override
  Widget build(BuildContext context) {{
    return Scaffold(
      backgroundColor: _bg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 300,
            backgroundColor: _bg,
            title: const Text('{title}', style: TextStyle(fontWeight: FontWeight.w900)),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [_bg, _bg2, _primary.withValues(alpha:0.5)],
                    stops: const [0, 0.5, 1],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: -100,
                      right: -100,
                      child: Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _primary.withValues(alpha:0.2),
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [_primary, _accent],
                              ),
                            ),
                            child: const Icon(Icons.gradient, color: Colors.white, size: 40),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '{title}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _GradientCard(
                    title: 'Creative Design',
                    desc: 'Vibrant gradient palette with modern design patterns.',
                  ),
                  const SizedBox(height: 16),
                  _GradientCard(
                    title: 'Enhanced UX',
                    desc: 'Beautiful animations and smooth interactions.',
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              child: SingleChildScrollView(
                child: const {enhanced_view_class}(),
              ),
            ),
          ),
        ],
      ),
    );
  }}
}}

class _GradientCard extends StatelessWidget {{
  final String title, desc;

  const _GradientCard({{required this.title, required this.desc}});

  @override
  Widget build(BuildContext context) {{
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xffe94560).withValues(alpha:0.8),
            const Color(0xfff39c12).withValues(alpha:0.6),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            desc,
            style: TextStyle(
              fontSize: 13,
              color: Colors.white.withValues(alpha:0.9),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }}
}}
'''
    
    else:  # Default minimalist design
        view_content = f'''import 'package:flutter/material.dart';
import '{module_short_name}_enhanced_view.dart';

/// {class_name} Best View - Premium Design
/// Theme: {theme["name"]} | Palette: {theme["palette"]}
class {best_view_class} extends StatelessWidget {{
  const {best_view_class}({{super.key}});

  @override
  Widget build(BuildContext context) {{
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 240,
            title: const Text('{title}', style: TextStyle(fontWeight: FontWeight.w800)),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.blueGrey,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star, color: Colors.white, size: 48),
                      const SizedBox(height: 16),
                      Text(
                        '{title}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Best View',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Creative premium design for {title}',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              child: SingleChildScrollView(
                child: const {enhanced_view_class}(),
              ),
            ),
          ),
        ],
      ),
    );
  }}
}}
'''
    
    return view_content


def find_all_modules():
    """Find all modules in the lib/modules directory."""
    modules = []
    
    if not MODULES_DIR.exists():
        print(f"Modules directory not found: {MODULES_DIR}")
        return modules
    
    idx = 0
    for item in sorted(MODULES_DIR.iterdir()):
        if item.is_dir() and not item.name.startswith("."):
            # Check if it's a flat module or parent
            has_sub_modules = any(
                sub.is_dir() and not sub.name.startswith(".")
                for sub in item.iterdir()
                if sub.is_dir()
            )
            
            if has_sub_modules:
                # Parent module - add all sub-modules
                for sub_item in sorted(item.iterdir()):
                    if sub_item.is_dir() and not sub_item.name.startswith("."):
                        modules.append((sub_item, item.name, idx))
                        idx += 1
            else:
                # Flat module
                modules.append((item, None, idx))
                idx += 1
    
    return modules


def generate_files():
    """Generate all best view files."""
    modules = find_all_modules()
    
    if not modules:
        print("No modules found!")
        return
    
    print(f"Found {len(modules)} modules. Generating BestView files...")
    
    for idx, (module_path, parent_module, theme_idx) in enumerate(modules):
        module_name = module_path.name
        
        # Skip certain system modules
        if module_name in ["home", "splash"]:
            continue
        
        try:
            output_file = module_path / f"{module_name}_best_view.dart"
            
            # Skip if already exists
            if output_file.exists():
                print(f"Skipping {module_name} (already exists)")
                continue
            
            content = create_best_view_file(module_path, module_name, theme_idx)
            
            output_file.write_text(content, encoding="utf-8")
            print(f"✓ Generated {module_name}_best_view.dart")
            
        except Exception as e:
            print(f"✗ Error generating {module_name}: {e}")
    
    print("\nDone! Generated BestView files for all modules.")


if __name__ == "__main__":
    generate_files()
