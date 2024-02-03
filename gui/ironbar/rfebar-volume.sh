function report_sink_may
{
  jq -r '
    select(.type == "PipeWire:Interface:Node")
      | select(.id == (env.default_audio_sink_id | tonumber))
      | select(.info.props["media.class"] == "Audio/Sink")
      | .info.params.Props.[]
      | select(has("channelVolumes") or has("mute"))
      | {channelVolumes, mute}
      | .volume = (.channelVolumes | add) / (.channelVolumes | length)
      | .volumepercent = ((.volume | cbrt) * 100 | round)
      | if .mute then "󰝟 " else "󰕾  \(.volumepercent)%" end
  ' <<<"$1"
}

default_audio_sink_id=
IFS=
pw-dump -m | jq --unbuffered -c '.[]' | while read -r event_json; do
  new_default_sink_name="$(jq -r '
    select(.type == "PipeWire:Interface:Metadata")
      | select(.props["metadata.name"] == "default")
      | .metadata.[]
      | select(.key == "default.audio.sink")
      | .value.name
  ' <<<"$event_json")"
  export new_default_sink_name

  if [ -n "$new_default_sink_name" ]; then
    default_audio_sink_id="$(pw-dump | jq -r '
      .[]
        | select(.info.props["node.name"] == env.new_default_sink_name)
        | .id
    ')"
    export default_audio_sink_id
    report_sink_may "$(pw-dump "$default_audio_sink_id" | jq -c '.[]')"
  fi

  if [ -n "$default_audio_sink_id" ]; then
    report_sink_may "$event_json"
  fi
done
