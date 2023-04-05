<script>
import axios from "axios";
export default {
  data() {
    return {
      rooms: [],
      guest: {
        id: this.$router.currentRoute.value.params.guest_id,
        name: null,
      },
      name: {
        alias: "Room Name",
        value: null,
      },
      room_selected: null,
    };
  },
  mounted() {
    this.findGuest();
    this.getRooms();
  },
  methods: {
    findGuest() {
      axios
        .get(`http://localhost:3000/guests/${this.guest.id}`)
        .then((response) => {
          this.guest.name = response.data.name;
        })
        .catch((error) => {
          this.$notify({
            type: "error",
            title: "Error",
            message: error,
            position: "bottom-right",
          });
        });
    },
    getRooms() {
      axios
        .get("http://localhost:3000/rooms")
        .then((response) => {
          this.rooms = response.data;
        })
        .catch((error) => {
          this.$notify({
            type: "error",
            title: "Error",
            message: error,
            position: "bottom-right",
          });
        });
    },
    createRoom() {
      this.$router.push(`room/add`);
    },
    async createRoomGuest(room_id) {
      axios
        .post("http://localhost:3000/room_guests", {
          room_id: room_id,
          guest_id: this.guest.id,
        })
        .then((response) => {
          if (response.data.status == "success") {
            this.loading = false;
            this.$notify({
              type: "success",
              title: "Success",
              message: "Created",
              position: "bottom-right",
            });
            this.$router.push(`room/${room_id}/${response.data.room_guest.id}/chat`);
          }
        })
        .catch((error) => {
          this.loading = false;
          this.$notify({
            type: "error",
            title: "Error",
            message: error,
            position: "bottom-right",
          });
        });
    },
  },
};
</script>
<template>
  <p
    class="mb-4 text-2xl text-center font-medium leading-tight text-neutral-800"
  >
    Rooms
  </p>
  <button
    type="button"
    class="mb-4 inline-block rounded border-0 px-6 pt-2.5 pb-2 text-xs font-medium uppercase leading-normal bg-neutral-300 hover:bg-neutral-400"
    x
    @click="createRoom()"
  >
    Create New Room
  </button>
  <div v-if="rooms.length == 0" class="p-5">
    <p
      class="mb-4 text-md text-center font-medium leading-tight text-neutral-700"
    >
      There's no room... Create your own room!
    </p>
  </div>
  <div
    class="grid sm:grid-cols-1 md:grid-cols-4 lg:grid-cols-4 xl:grid-cols-4 2xl:grid-cols-6 justify-center gap-4"
  >
    <div v-for="room in rooms" class="flex justify-center p-5">
      <div class="block max-w-sm rounded-lg bg-white p-6 shadow-lg">
        <p
          class="mb-4 text-xl text-center font-medium leading-tight text-neutral-800"
        >
          {{ room.name }}
        </p>
        <button
          type="button"
          class="inline-block rounded border-0 px-6 pt-2.5 pb-2 text-xs font-medium uppercase leading-normal bg-sky-300 hover:bg-sky-400"
          @click="createRoomGuest(room.id)"
        >
          Join Room
        </button>
      </div>
    </div>
  </div>
</template>
