---
description: "How PurposeNotes handles your data: no accounts, no servers of ours, no analytics."
eyebrow: "PurposeNotes · Legal"
nav-privacy: true
---

# PurposeNotes Privacy Policy

_Last updated: 2026-08-26_

## The short version

PurposeNotes is a local-first notes app. Your notes live on your device. We
run no servers, require no account, and collect no analytics. Nothing you
write is sent to us — we could not read your notes even if we wanted to,
because we never receive them.

## What we collect

**Nothing.** PurposeNotes has:

- **No accounts.** There is no sign-up, no email, no password stored with us.
- **No servers of ours.** The app talks to no PurposeNotes-operated backend.
- **No analytics or tracking.** No analytics SDKs, no advertising identifiers,
  no fingerprinting, no third-party trackers.
- **No data sale or sharing.** We hold no user data, so there is nothing to
  sell or share.

## Where your data lives

Your notes, tasks, goals, purposes, and attachments are stored in a database
on your device. They stay there unless you turn on one of the optional
features below or export them yourself.

## Optional features that use the network

Each of these is off until you use it, and each is described so you can
decide:

### iCloud sync (optional)

If you enable sync, PurposeNotes syncs through **your** iCloud account using
Apple's CloudKit **private database**. Sync payloads are **end-to-end
encrypted on your device before upload** — Apple and we see only encrypted
envelopes, never plaintext notes, embeddings, or keys. The encryption keys
are derived from your passphrase and protected via your Apple ID and iCloud
Keychain; there is no server-side escrow, and we cannot recover your data if
you lose both. Apple's handling of iCloud data is governed by
[Apple's privacy policy](https://www.apple.com/legal/privacy/).

### On-device AI model downloads (optional, user-initiated)

AI features run **on your device**. If you choose to enable them, the app
downloads model files you explicitly request from Hugging Face
(huggingface.co). That download sends an ordinary web request (your IP
address, the requested file) to Hugging Face, governed by their privacy
policy. No note content is included in the request.

### Cloud AI routing (optional, off by default)

Cloud AI is **opt-in, off by default**, and asks for **per-action
confirmation** before any request. Only the content you confirm for that
specific action is sent, using an API key you supply. Every AI and MCP access
is recorded in the on-device **AI Access Log** so you can audit exactly what
left the device and when.

### Other narrow, user-controlled cases

- **Map tiles:** if you open the Map view, Apple MapKit fetches map tiles
  anonymously. Reading photo locations (EXIF) for the map is off by default.
- **Diagnostics:** crash reporting is **off by default**. If you turn it on,
  crash reports contain no note content, titles, or graph statistics.
- **Spotlight:** indexing note **titles** for system search is off by default.

## Data deletion

Deleting data in the app deletes it from your device. If sync is enabled,
deletions propagate to your iCloud private database. Deleting the app removes
its local data per standard iOS/macOS behavior; you can also remove the app's
iCloud data via your device's iCloud storage management.

## Children

PurposeNotes collects no data from anyone, including children.

## Changes

If this policy changes, the updated version will be posted at
https://quantrammer.com/purposenotes/privacy with a new "Last updated" date. Because we
collect nothing, changes would typically only describe new optional features.

## Contact

Questions about privacy: **privacy@quantrammer.com**
